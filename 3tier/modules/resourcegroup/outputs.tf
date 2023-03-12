output "resource_group_name" {
    value = azurerm_resource_group.azure-rg.name
    description = "Name of the resource group."
}

output "location_id" {
    value = azurerm_resource_group.azure-rg.location.id
    description = "Location id of the resource group"
}
