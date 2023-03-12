resource "azurerm_resource_group" "azure-rg" {
  name     = var.rgname
  location = var.rglocation
}
