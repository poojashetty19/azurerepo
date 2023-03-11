provider "azurerm" {
  features {}
}

data "azurerm_app_service_plan" "asp1" {
  name                = "${var.app_service_plan_name}"
  resource_group_name = "${var.resource_group_name}"
}

data "azurerm_app_service" "app1" {
  name                = "${var.app_service_name}"
  resource_group_name = "${var.resource_group_name}"
}

output "instance_metadata" {
  value = jsonencode({
    compute = {
      name        = data.azurerm_app_service.app1.name
      location    = data.azurerm_app_service_plan.asp1.location
      vmSize      = data.azurerm_app_service_plan.asp1.sku[0].name
    },
  })
}






