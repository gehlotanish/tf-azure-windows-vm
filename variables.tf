variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
}

variable "compute_name" {
  description = "The computer name assigned inside the OS."
  type        = string
  default     = "localhost"
}

variable "location" {
  description = "The Azure region to deploy the resources in."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "vm_size" {
  description = "The size of the virtual machine."
  type        = string
}

variable "license_type" {
  description = "Specifies the BYOL license type."
  type        = string
  default     = null
}

variable "vm_image_id" {
  description = "Custom image ID to use."
  type        = string
  default     = null
}

variable "vm_image" {
  description = "Marketplace image details if vm_image_id is null."
  type = object({
    offer     = string
    publisher = string
    sku       = string
    version   = string
  })
  default = null
}

variable "zone_id" {
  description = "The availability zone to use."
  type        = string
  default     = null
}

variable "availability_set_id" {
  description = "ID of the availability set, if any."
  type        = string
  default     = null
}

variable "admin_username" {
  description = "The admin username for the VM."
  type        = string
}

variable "admin_password" {
  description = "The admin password for the VM."
  type        = string
  sensitive   = true
}

variable "user_data" {
  description = "Cloud-init or custom data script."
  type        = string
  default     = null
}

variable "encryption_at_host_enabled" {
  description = "Enable encryption at host."
  type        = bool
  default     = false
}

variable "vm_agent_platform_updates_enabled" {
  description = "Enable VM guest agent platform updates."
  type        = bool
  default     = false
}

variable "vtpm_enabled" {
  description = "Enable virtual TPM."
  type        = bool
  default     = false
}

variable "secure_boot_enabled" {
  description = "Enable secure boot."
  type        = bool
  default     = false
}

variable "disk_controller_type" {
  description = "The type of disk controller to use."
  type        = string
  default     = "SCSI"
}

variable "patch_mode" {
  description = "The mode of patching to use."
  type        = string
  default     = "Manual"
}

variable "patching_reboot_setting" {
  description = "Reboot setting if using automatic patching."
  type        = string
  default     = null
}

variable "hotpatching_enabled" {
  description = "Enable hotpatching on supported images."
  type        = bool
  default     = false
}

variable "spot_instance_enabled" {
  description = "Use spot instance for VM."
  type        = bool
  default     = false
}

variable "spot_instance_max_bid_price" {
  description = "Max bid price for spot instance."
  type        = number
  default     = null
}

variable "spot_instance_eviction_policy" {
  description = "Eviction policy for spot VM."
  type        = string
  default     = "Deallocate"
}

variable "diagnostics_storage_account_name" {
  description = "Storage account for boot diagnostics."
  type        = string
  default     = null
}

variable "os_disk_name" {
  description = "Name of the OS disk."
  type        = string
}

variable "os_disk_caching" {
  description = "Caching setting for the OS disk."
  type        = string
  default     = "ReadWrite"
}

variable "os_disk_storage_account_type" {
  description = "Storage type for the OS disk."
  type        = string
}

variable "os_disk_size_gb" {
  description = "Size of the OS disk in GB."
  type        = number
}

variable "disk_encryption_set_id" {
  description = "ID of the disk encryption set."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to assign to the resources."
  type        = map(string)
  default     = {}
}

variable "vm_plan" {
  description = "VM purchase plan for marketplace images."
  type = object({
    name      = string
    product   = string
    publisher = string
  })
  default = null
}

variable "ultra_ssd_enabled" {
  description = "Enable Ultra SSD capability."
  type        = bool
  default     = false
}

variable "storage_data_disk_config" {
  description = "Map of configurations for additional data disks."
  type = map(object({
    name                 = optional(string)
    lun                  = optional(number)
    caching              = string
    create_option        = string
    disk_size_gb         = number
    source_resource_id   = optional(string)
    storage_account_type = string
    extra_tags           = optional(map(string))
    zone                 = optional(string)
  }))
  default = {}
}

variable "azure_monitor_agent_user_assigned_identity" {
  description = "User-assigned identity used by Azure Monitor Agent."
  type        = string
  default     = null
}

variable "identity" {
  description = "Configuration for VM identity."
  type = object({
    type         = optional(string)
    identity_ids = optional(list(string))
  })
  default = {}
}

variable "network_interface_name" {
  type        = string
  description = "Name for the network interface to be created"
}


variable "enable_ip_forwarding" {
  type        = bool
  default     = false
  description = "Whether IP forwarding is enabled"
}

variable "enable_accelerated_networking" {
  type        = bool
  default     = false
  description = "Enable accelerated networking"
}

variable "dns_servers" {
  type        = list(string)
  default     = []
  description = "List of DNS servers"
}

variable "ip_configurations" {
  type = list(object({
    name                          = string
    subnet_id                     = string
    private_ip_address_allocation = string
    private_ip_address            = optional(string)
    public_ip_address_id          = optional(string)
    primary                       = optional(bool)
  }))
  description = "List of IP configurations"
}

variable "public_ip_enabled" {
  type        = bool
  description = "Whether to create a public IP"
  default     = false
}

variable "public_ip_zones" {
  type        = list(string)
  description = "The availability zones for the public IP"
  default     = []
}

variable "custom_dns_label" {
  type        = string
  description = "Custom DNS label for the public IP"
  default     = ""
}


variable "enable_diagnostics" {
  description = "Enable diagnostic settings for the VM"
  type        = bool
  default     = false
}

variable "log_categories" {
  type        = list(string)
  default     = null
  description = "List of log categories. Defaults to all available."
}

variable "excluded_log_categories" {
  type        = list(string)
  default     = []
  description = "List of log categories to exclude."
}

variable "metric_categories" {
  type        = list(string)
  default     = null
  description = "List of metric categories. Defaults to all available."
}

variable "logs_destinations_ids" {
  type        = list(string)
  default     = []
  description = <<EOD
List of destination resources IDs for logs diagnostic destination.
Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.
If you want to use Azure EventHub as a destination, you must provide a formatted string containing both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the <code>&#124;</code> character.
EOD
}

variable "log_analytics_destination_type" {
  type        = string
  default     = "AzureDiagnostics"
  description = "When set to 'Dedicated' logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy AzureDiagnostics table."
}

variable "additional_network_interface_ids" {
  description = "Optional list of additional network interface IDs to attach to the VM"
  type        = list(string)
  default     = []
}

variable "enable_aad_login_extension" {
  description = "Enable the AAD Login extension for Windows VM"
  type        = bool
  default     = false
}

variable "enable_crowdstrike_falcon_extension" {
  description = "Enable the CrowdStrike Falcon Sensor Windows VM extension"
  type        = bool
  default     = false
}

variable "crowdstrike_falcon_tags" {
  description = "Optional tags to assign to the sensor (comma-separated)"
  type        = string
  default     = null
}

variable "crowdstrike_falcon_cloud" {
  description = "CrowdStrike cloud region (us-1, us-2, eu-1, us-gov-1, autodiscover)"
  type        = string
  default     = "autodiscover"
}

variable "crowdstrike_falcon_client_id" {
  description = "CrowdStrike API Client ID"
  type        = string
  sensitive   = true
  default     = null
}

variable "crowdstrike_falcon_client_secret" {
  description = "CrowdStrike API Client Secret"
  type        = string
  sensitive   = true
  default     = null
}

variable "enable_windows_custom_script_extension" {
  description = "Enable the Windows Custom Script Extension"
  type        = bool
  default     = false
}

variable "windows_custom_script_file_uris" {
  description = "List of file URIs (e.g., SAS URLs) to download for the custom script extension"
  type        = list(string)
  default     = []
}

variable "windows_custom_script_command" {
  description = "Command to execute (e.g., powershell -ExecutionPolicy Bypass -File script.ps1)"
  type        = string
  default     = null
}

variable "enable_autoshut_down" {
  description = "Enable auto-shutdown schedule for the VM"
  type        = bool
  default     = false
}

variable "auto_shutdown_time" {
  description = "Time for daily auto-shutdown (format: HHMM, e.g., 1800 for 6:00 PM)"
  type        = string
  default     = "1800"
}

variable "time_zone" {
  description = "Timezone for the auto-shutdown schedule"
  type        = string
  default     = "UTC"
}

variable "enable_agency_dc" {
  description = "Enable domain join to agency domain controller"
  type        = bool
  default     = false
}

variable "enable_transit_dc" {
  description = "Enable domain join to transit domain controller"
  type        = bool
  default     = false
}

variable "agency_dc_config" {
  description = "Configuration for agency domain controller join"
  type = object({
    domain_name = string
    ou_path     = string
    username    = string
    password    = string
  })
  default = {
    domain_name = ""
    ou_path     = ""
    username    = ""
    password    = ""
  }
}

variable "transit_dc_config" {
  description = "Configuration for transit domain controller join"
  type = object({
    domain_name = string
    ou_path     = string
    username    = string
    password    = string
  })
  default = {
    domain_name = ""
    ou_path     = ""
    username    = ""
    password    = ""
  }
}
