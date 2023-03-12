resource "azurerm_network_interface" "app-interface" {
  name                = "app-nic"
  location            = var.resource_group
  resource_group_name = var.location

  ip_configuration {
    name                          = "app-ip"
    subnet_id                     = var.app_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_windows_virtual_machine" "appnewvm" {
  name                  = "app-vm"
  admin_username        = "azureuser"
  admin_password        = random_password.password.result
  location              = azurerm_resource_group.azure-rg.location
  resource_group_name   = azurerm_resource_group.azure-rg.rg.name
  size                  = var.vm_size

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = var.publisher
    offer     = "WindowsServer"
    sku       = var.vm_sku
    version   = "latest"
  }
  
  resource "azurerm_network_interface" "web-interface" {
  name                = "web-nic"
  location            = var.resource_group
  resource_group_name = var.location

  ip_configuration {
    name                          = "web-ip"
    subnet_id                     = var.web_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_windows_virtual_machine" "webnewvm" {
  name                  = "web-vm"
  admin_username        = "azureuser"
  admin_password        = random_password.password.result
  location              = azurerm_resource_group.azure-rg.location
  resource_group_name   = azurerm_resource_group.azure-rg.rg.name
  size                  = var.vm_size

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = var.publisher
    offer     = "WindowsServer"
    sku       = var.vm_sku
    version   = "latest"
  }
  
  resource "random_id" "random_id" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = azurerm_resource_group.rg.name
  }

  byte_length = 8
}

resource "random_password" "password" {
  length      = 20
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
  special     = true
}
