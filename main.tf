resource "azurerm_public_ip" "main" {
  count = var.public_ip_enabled ? 1 : 0

  name                = "pip-${var.vm_name}"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku               = "Standard"
  allocation_method = "Static"
  domain_name_label = var.custom_dns_label
  zones             = var.public_ip_zones

  tags = var.tags
}

resource "azurerm_network_interface" "main" {
  name                           = var.network_interface_name
  location                       = var.location
  resource_group_name            = var.resource_group_name
  ip_forwarding_enabled          = var.enable_ip_forwarding
  accelerated_networking_enabled = var.enable_accelerated_networking
  dns_servers                    = var.dns_servers
  tags                           = var.tags

  dynamic "ip_configuration" {
    for_each = var.ip_configurations
    content {
      name                          = ip_configuration.value.name
      subnet_id                     = ip_configuration.value.subnet_id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      private_ip_address            = lookup(ip_configuration.value, "private_ip_address", null)
      public_ip_address_id          = var.public_ip_enabled ? azurerm_public_ip.main[0].id : null
      primary                       = lookup(ip_configuration.value, "primary", false)
    }
  }
}

resource "azurerm_windows_virtual_machine" "win_vm" {
  name                                                   = var.vm_name
  location                                               = var.location
  resource_group_name                                    = var.resource_group_name
  network_interface_ids                                  = concat([azurerm_network_interface.main.id], var.additional_network_interface_ids)
  size                                                   = var.vm_size
  license_type                                           = var.license_type
  source_image_id                                        = var.vm_image_id
  zone                                                   = var.zone_id
  availability_set_id                                    = var.availability_set_id
  admin_username                                         = var.admin_username
  admin_password                                         = var.admin_password
  computer_name                                          = var.compute_name
  user_data                                              = var.user_data
  encryption_at_host_enabled                             = var.encryption_at_host_enabled
  vm_agent_platform_updates_enabled                      = var.vm_agent_platform_updates_enabled
  vtpm_enabled                                           = var.vtpm_enabled
  secure_boot_enabled                                    = var.secure_boot_enabled
  disk_controller_type                                   = var.disk_controller_type
  provision_vm_agent                                     = true
  enable_automatic_updates                               = true
  patch_mode                                             = var.patch_mode
  patch_assessment_mode                                  = var.patch_mode == "AutomaticByPlatform" ? var.patch_mode : "ImageDefault"
  hotpatching_enabled                                    = var.hotpatching_enabled
  bypass_platform_safety_checks_on_user_schedule_enabled = var.hotpatching_enabled ? false : var.patch_mode == "AutomaticByPlatform"
  reboot_setting                                         = var.patch_mode == "AutomaticByPlatform" ? var.patching_reboot_setting : null
  priority                                               = var.spot_instance_enabled ? "Spot" : "Regular"
  max_bid_price                                          = var.spot_instance_enabled ? var.spot_instance_max_bid_price : null
  eviction_policy                                        = var.spot_instance_enabled ? var.spot_instance_eviction_policy : null
  tags                                                   = var.tags

  dynamic "boot_diagnostics" {
    for_each = var.diagnostics_storage_account_name != null ? [1] : []
    content {
      storage_account_uri = "https://${var.diagnostics_storage_account_name}.blob.core.windows.net"
    }
  }

  os_disk {
    name                   = var.os_disk_name
    caching                = var.os_disk_caching
    storage_account_type   = var.os_disk_storage_account_type
    disk_size_gb           = var.os_disk_size_gb
    disk_encryption_set_id = var.disk_encryption_set_id
  }

  dynamic "source_image_reference" {
    for_each = var.vm_image_id == null ? [0] : []
    content {
      offer     = var.vm_image.offer
      publisher = var.vm_image.publisher
      sku       = var.vm_image.sku
      version   = var.vm_image.version
    }
  }

  dynamic "plan" {
    for_each = var.vm_plan[*]
    content {
      name      = var.vm_plan.name
      product   = var.vm_plan.product
      publisher = var.vm_plan.publisher
    }
  }

  dynamic "identity" {
    for_each = var.azure_monitor_agent_user_assigned_identity != null || try(var.identity.type == "UserAssigned", false) ? [1] : []
    content {
      type = join(", ", toset(compact([
        "UserAssigned",
        try(var.identity.type, "")
      ])))

      identity_ids = compact(concat(
        try(var.identity.identity_ids, []),
        [var.azure_monitor_agent_user_assigned_identity]
      ))
    }
  }

  dynamic "additional_capabilities" {
    for_each = var.ultra_ssd_enabled[*]
    content {
      ultra_ssd_enabled = var.ultra_ssd_enabled
    }
  }
}

resource "azurerm_managed_disk" "win_vm" {
  for_each = var.storage_data_disk_config

  name                   = coalesce(each.value.name, each.key)
  location               = var.location
  resource_group_name    = var.resource_group_name
  zone                   = can(regex("_zrs$", lower(each.value.storage_account_type))) ? null : var.zone_id
  storage_account_type   = each.value.storage_account_type
  create_option          = each.value.create_option
  disk_size_gb           = each.value.disk_size_gb
  source_resource_id     = contains(["Copy", "Restore"], each.value.create_option) ? each.value.source_resource_id : null
  disk_encryption_set_id = var.disk_encryption_set_id
  tags                   = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "win_vm" {
  for_each = var.storage_data_disk_config

  managed_disk_id    = azurerm_managed_disk.win_vm[each.key].id
  virtual_machine_id = azurerm_windows_virtual_machine.win_vm.id
  lun                = coalesce(each.value.lun, index(keys(var.storage_data_disk_config), each.key))
  caching            = each.value.caching
}


resource "azurerm_monitor_diagnostic_setting" "win_vm" {
  count              = var.enable_diagnostics ? 1 : 0
  name               = "${var.vm_name}-diagnostic"
  target_resource_id = azurerm_windows_virtual_machine.win_vm.id

  storage_account_id             = local.storage_id
  log_analytics_workspace_id     = local.log_analytics_id
  log_analytics_destination_type = local.log_analytics_destination_type
  eventhub_authorization_rule_id = local.eventhub_authorization_rule_id
  eventhub_name                  = local.eventhub_name

  dynamic "enabled_log" {
    for_each = local.log_categories

    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = local.metrics

    content {
      category = metric.key
      enabled  = metric.value.enabled
    }
  }
}

