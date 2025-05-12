data "azurerm_monitor_diagnostic_categories" "main" {
  count       = var.enable_diagnostics ? 1 : 0
  resource_id = azurerm_windows_virtual_machine.win_vm.id
}
