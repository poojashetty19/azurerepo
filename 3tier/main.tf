provider "azurerm" {
  features {}
}

module "resourcegroup" {
  source         = "./module/Resource-group"
  name           = var.rgname
  location       = var.rglocation
}
