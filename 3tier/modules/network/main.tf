resource "azurerm_virtual_network" "vnetnew" {
  name                = "vnet1"
  resource_group_name = var.resource_group
  location            = var.location
  address_space       = [var.vnetip]
}

resource "azurerm_subnet" "web-subnet" {
  name                 = "web-subnet"
  virtual_network_name = azurerm_virtual_network.vnetnew.name
  resource_group_name  = var.resource_group
  address_prefixes     = [var.websubnet]
}

resource "azurerm_subnet" "app-subnet" {
  name                 = "app-subnet"
  virtual_network_name = azurerm_virtual_network.vnetnew.name
  resource_group_name  = var.resource_group
  address_prefixes     = [var.appsubnet]
}

resource "azurerm_subnet" "db-subnet" {
  name                 = "db-subnet"
  virtual_network_name = azurerm_virtual_network.vnetnew.name
  resource_group_name  = var.resource_group
  address_prefixes     = [var.dbsubnet]
}
