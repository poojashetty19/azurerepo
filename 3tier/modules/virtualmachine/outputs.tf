output "appvm_admin_password" {
  sensitive = true
  value     = azurerm_windows_virtual_machine.appnewvm.admin_password
}

output "webvm_admin_password" {
  sensitive = true
  value     = azurerm_windows_virtual_machine.webnewvm.admin_password
}
