# template-terraform
Template repository for all terraform module repositories

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.25.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.25.0 |
## Modules

No modules.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The admin password for the VM. | `string` | n/a | yes |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | The admin username for the VM. | `string` | n/a | yes |
| <a name="input_availability_set_id"></a> [availability\_set\_id](#input\_availability\_set\_id) | ID of the availability set, if any. | `string` | `null` | no |
| <a name="input_azure_monitor_agent_user_assigned_identity"></a> [azure\_monitor\_agent\_user\_assigned\_identity](#input\_azure\_monitor\_agent\_user\_assigned\_identity) | User-assigned identity used by Azure Monitor Agent. | `string` | `null` | no |
| <a name="input_compute_name"></a> [compute\_name](#input\_compute\_name) | The computer name assigned inside the OS. | `string` | n/a | yes |
| <a name="input_custom_dns_label"></a> [custom\_dns\_label](#input\_custom\_dns\_label) | Custom DNS label for the public IP | `string` | `""` | no |
| <a name="input_diagnostics_storage_account_name"></a> [diagnostics\_storage\_account\_name](#input\_diagnostics\_storage\_account\_name) | Storage account for boot diagnostics. | `string` | n/a | yes |
| <a name="input_disk_controller_type"></a> [disk\_controller\_type](#input\_disk\_controller\_type) | The type of disk controller to use. | `string` | `"SCSI"` | no |
| <a name="input_disk_encryption_set_id"></a> [disk\_encryption\_set\_id](#input\_disk\_encryption\_set\_id) | ID of the disk encryption set. | `string` | `null` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | List of DNS servers | `list(string)` | `[]` | no |
| <a name="input_enable_accelerated_networking"></a> [enable\_accelerated\_networking](#input\_enable\_accelerated\_networking) | Enable accelerated networking | `bool` | `false` | no |
| <a name="input_enable_diagnostics"></a> [enable\_diagnostics](#input\_enable\_diagnostics) | Enable diagnostic settings for the VM | `bool` | `false` | no |
| <a name="input_enable_ip_forwarding"></a> [enable\_ip\_forwarding](#input\_enable\_ip\_forwarding) | Whether IP forwarding is enabled | `bool` | `false` | no |
| <a name="input_encryption_at_host_enabled"></a> [encryption\_at\_host\_enabled](#input\_encryption\_at\_host\_enabled) | Enable encryption at host. | `bool` | `false` | no |
| <a name="input_excluded_log_categories"></a> [excluded\_log\_categories](#input\_excluded\_log\_categories) | List of log categories to exclude. | `list(string)` | `[]` | no |
| <a name="input_hotpatching_enabled"></a> [hotpatching\_enabled](#input\_hotpatching\_enabled) | Enable hotpatching on supported images. | `bool` | `false` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | Configuration for VM identity. | <pre>object({<br>    type         = optional(string)<br>    identity_ids = optional(list(string))<br>  })</pre> | `{}` | no |
| <a name="input_ip_configurations"></a> [ip\_configurations](#input\_ip\_configurations) | List of IP configurations | <pre>list(object({<br>    name                          = string<br>    subnet_id                     = string<br>    private_ip_address_allocation = string<br>    private_ip_address            = optional(string)<br>    public_ip_address_id          = optional(string)<br>    primary                       = optional(bool)<br>  }))</pre> | n/a | yes |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | Specifies the BYOL license type. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region to deploy the resources in. | `string` | n/a | yes |
| <a name="input_log_analytics_destination_type"></a> [log\_analytics\_destination\_type](#input\_log\_analytics\_destination\_type) | When set to 'Dedicated' logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy AzureDiagnostics table. | `string` | `"AzureDiagnostics"` | no |
| <a name="input_log_categories"></a> [log\_categories](#input\_log\_categories) | List of log categories. Defaults to all available. | `list(string)` | `null` | no |
| <a name="input_logs_destinations_ids"></a> [logs\_destinations\_ids](#input\_logs\_destinations\_ids) | List of destination resources IDs for logs diagnostic destination.<br>Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.<br>If you want to use Azure EventHub as a destination, you must provide a formatted string containing both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the <code>&#124;</code> character. | `list(string)` | n/a | yes |
| <a name="input_metric_categories"></a> [metric\_categories](#input\_metric\_categories) | List of metric categories. Defaults to all available. | `list(string)` | `null` | no |
| <a name="input_network_interface_id"></a> [network\_interface\_id](#input\_network\_interface\_id) | ID of the NIC to associate with the VM. | `string` | n/a | yes |
| <a name="input_network_interface_name"></a> [network\_interface\_name](#input\_network\_interface\_name) | Name for the network interface to be created | `string` | n/a | yes |
| <a name="input_os_disk_caching"></a> [os\_disk\_caching](#input\_os\_disk\_caching) | Caching setting for the OS disk. | `string` | `"ReadWrite"` | no |
| <a name="input_os_disk_name"></a> [os\_disk\_name](#input\_os\_disk\_name) | Name of the OS disk. | `string` | n/a | yes |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb) | Size of the OS disk in GB. | `number` | n/a | yes |
| <a name="input_os_disk_storage_account_type"></a> [os\_disk\_storage\_account\_type](#input\_os\_disk\_storage\_account\_type) | Storage type for the OS disk. | `string` | n/a | yes |
| <a name="input_patch_mode"></a> [patch\_mode](#input\_patch\_mode) | The mode of patching to use. | `string` | `"Manual"` | no |
| <a name="input_patching_reboot_setting"></a> [patching\_reboot\_setting](#input\_patching\_reboot\_setting) | Reboot setting if using automatic patching. | `string` | `null` | no |
| <a name="input_public_ip_enabled"></a> [public\_ip\_enabled](#input\_public\_ip\_enabled) | Whether to create a public IP | `bool` | `false` | no |
| <a name="input_public_ip_zones"></a> [public\_ip\_zones](#input\_public\_ip\_zones) | The availability zones for the public IP | `list(string)` | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_secure_boot_enabled"></a> [secure\_boot\_enabled](#input\_secure\_boot\_enabled) | Enable secure boot. | `bool` | `false` | no |
| <a name="input_spot_instance_enabled"></a> [spot\_instance\_enabled](#input\_spot\_instance\_enabled) | Use spot instance for VM. | `bool` | `false` | no |
| <a name="input_spot_instance_eviction_policy"></a> [spot\_instance\_eviction\_policy](#input\_spot\_instance\_eviction\_policy) | Eviction policy for spot VM. | `string` | `"Deallocate"` | no |
| <a name="input_spot_instance_max_bid_price"></a> [spot\_instance\_max\_bid\_price](#input\_spot\_instance\_max\_bid\_price) | Max bid price for spot instance. | `number` | `null` | no |
| <a name="input_storage_data_disk_config"></a> [storage\_data\_disk\_config](#input\_storage\_data\_disk\_config) | Map of configurations for additional data disks. | <pre>map(object({<br>    name                 = optional(string)<br>    lun                  = optional(number)<br>    caching              = string<br>    create_option        = string<br>    disk_size_gb         = number<br>    source_resource_id   = optional(string)<br>    storage_account_type = string<br>    extra_tags           = optional(map(string))<br>    zone                 = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to assign to the resources. | `map(string)` | `{}` | no |
| <a name="input_ultra_ssd_enabled"></a> [ultra\_ssd\_enabled](#input\_ultra\_ssd\_enabled) | Enable Ultra SSD capability. | `bool` | `false` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | Cloud-init or custom data script. | `string` | `null` | no |
| <a name="input_vm_agent_platform_updates_enabled"></a> [vm\_agent\_platform\_updates\_enabled](#input\_vm\_agent\_platform\_updates\_enabled) | Enable VM guest agent platform updates. | `bool` | `false` | no |
| <a name="input_vm_image"></a> [vm\_image](#input\_vm\_image) | Marketplace image details if vm\_image\_id is null. | <pre>object({<br>    offer     = string<br>    publisher = string<br>    sku       = string<br>    version   = string<br>  })</pre> | `null` | no |
| <a name="input_vm_image_id"></a> [vm\_image\_id](#input\_vm\_image\_id) | Custom image ID to use. | `string` | `null` | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | The name of the virtual machine. | `string` | n/a | yes |
| <a name="input_vm_plan"></a> [vm\_plan](#input\_vm\_plan) | VM purchase plan for marketplace images. | <pre>object({<br>    name      = string<br>    product   = string<br>    publisher = string<br>  })</pre> | `null` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | The size of the virtual machine. | `string` | n/a | yes |
| <a name="input_vtpm_enabled"></a> [vtpm\_enabled](#input\_vtpm\_enabled) | Enable virtual TPM. | `bool` | `false` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | The availability zone to use. | `string` | `null` | no |  
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_data_disk_ids"></a> [data\_disk\_ids](#output\_data\_disk\_ids) | List of data disk IDs attached to the VM. |
| <a name="output_vm_id"></a> [vm\_id](#output\_vm\_id) | The ID of the virtual machine. |
| <a name="output_vm_name"></a> [vm\_name](#output\_vm\_name) | The name of the virtual machine. |
| <a name="output_vm_private_ip"></a> [vm\_private\_ip](#output\_vm\_private\_ip) | The private IP address of the virtual machine. |
<!-- END_TF_DOCS -->

## Usage

```tf

# Public IP Configuration
public_ip_enabled       = true
public_ip_zones         = ["1", "2"]
custom_dns_label        = "mycustomdnslabel"

# Network Interface Configuration
enable_ip_forwarding    = true
enable_accelerated_networking = true
dns_servers             = ["8.8.8.8", "8.8.4.4"]
ip_configurations       = [
  {
    name                          = "internal"
    subnet_id                     = "my-subnet-id"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = null
    primary                       = true
  }
]

# General Configuration
location                = "East US"
resource_group_name     = "my-resource-group"
network_interface_name  = "my-network-interface"
vm_name                 = "my-windows-vm"
vm_size                 = "Standard_DS1_v2"
license_type            = "Windows_Server"
availability_set_id     = "my-availability-set-id"
zone_id                 = "1"
tags                    = {
  "Environment" = "Production"
  "Project"     = "VMDeployment"
}

# Admin Settings
admin_username          = "adminuser"
admin_password          = "your-secure-password"
compute_name            = "my-windows-computer"
user_data               = "#cloud-config-script"

# VM Image
vm_image_id             = "my-image-id"
vm_plan                 = {
  name      = "my-vm-plan"
  product   = "WindowsServer"
  publisher = "Microsoft"
}

# OS Disk Configuration
os_disk_name            = "my-os-disk"
os_disk_caching         = "ReadWrite"
os_disk_storage_account_type = "Standard_LRS"
os_disk_size_gb         = 50
disk_encryption_set_id  = "my-disk-encryption-set-id"



# Spot Instance Configuration
spot_instance_enabled    = false
spot_instance_max_bid_price = null
spot_instance_eviction_policy = "Deallocate"

# Identity Configuration
identity = {
  type           = "SystemAssigned"
  identity_ids   = []
}

# Ultra SSD Configuration
ultra_ssd_enabled       = []

# Hotpatching Configuration
hotpatching_enabled     = false
patch_mode              = "AutomaticByPlatform"
patching_reboot_setting = "Always"

# Diagnostics
enable_diagnostics             = true
```
