output "vm_id" {
  description = "The ID of the virtual machine."
  value       = azurerm_windows_virtual_machine.win_vm.id
}

output "vm_name" {
  description = "The name of the virtual machine."
  value       = azurerm_windows_virtual_machine.win_vm.name
}

output "vm_private_ip" {
  description = "The private IP address of the virtual machine."
  value       = azurerm_windows_virtual_machine.win_vm.private_ip_address
}

output "data_disk_ids" {
  description = "List of data disk IDs attached to the VM."
  value       = [for disk in azurerm_managed_disk.win_vm : disk.id]
}
