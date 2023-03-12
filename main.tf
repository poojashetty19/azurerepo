provider "azurerm" {
  features {}
}

module "resourcegroup" {
  source         = "./module/Resource-group"
  name           = var.rgname
  location       = var.rglocation
}

module "database" {
  source = "./modules/database"
  location = var.rglocation
  resource_group = var.rgname
  database_server = var.database_server
  database_version = var.database_version
  database_username = var.database_username
  database_password = var.database_password
}

module "virtualmachine" {
    source         = "./modules/virtualmachine"
    location = module.resourcegroup.location_id
    resource_group = module.resourcegroup.resource_group_name
    vm_size = var.vm_size
    vm_sku = var.vm_sku
    publisher = var.publisher
    web_subnet_id = module.network.websubnet_id
    app_subnet_id = module.network.appsubnet_id
}

module "network" {
    source = "./modules/network"
    vnetip       = var.vnetip
    websubnet  = var.websubnet
    appsubnet  = var.appsubnet
    dbsubnet   = var.dbsubnet
    web_subnet_id  = module.network.websubnet_id
    app_subnet_id  = module.network.appsubnet_id
    db_subnet_id   = module.network.dbsubnet_id
}
