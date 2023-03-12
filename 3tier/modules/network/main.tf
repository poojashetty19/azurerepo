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

resource "azurerm_network_security_group" "app-nsg" {
  name                = "web-nsg"
  location            = var.location
  resource_group_name = var.resource_group
  
  security_rule {
    name                       = "rule-1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "22"
  }
  
  security_rule {
    name                       = "rule-2"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_address_prefix      = "168.0.2.0/24"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "22"
}
}
resource "azurerm_subnet_network_security_group_association" "app-nsg-subnet" {
  subnet_id                 = var.app_subnet_id
  network_security_group_id = azurerm_network_security_group.app-nsg.id
}

resource "azurerm_network_security_group" "web-nsg" {
    name = "app-nsg"
    location = var.location
    resource_group_name = var.resource_group

    security_rule {
        name = "rule-1"
        priority = 100
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_address_prefix = "162.0.1.0/24"
        source_port_range = "*"
        destination_address_prefix = "*"
        destination_port_range = "22"
    }
    
    security_rule {
        name = "rule-2"
        priority = 101
        direction = "Outbound"
        access = "Allow"
        protocol = "Tcp"
        source_address_prefix = "162.168.1.0/24"
        source_port_range = "*"
        destination_address_prefix = "*"
        destination_port_range = "22"
    }
}

resource "azurerm_subnet_network_security_group_association" "web-nsg-subnet" {
  subnet_id                 = var.web_subnet_id
  network_security_group_id = azurerm_network_security_group.web-nsg.id
}


resource "azurerm_network_security_group" "db-nsg" {
    name = "db-nsg"
    location = var.location
    resource_group_name = var.resource_group

    security_rule {
        name = "rule-1"
        priority = 101
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_address_prefix = "192.168.2.0/24"
        source_port_range = "*"
        destination_address_prefix = "*"
        destination_port_range = "3306"
    }
    
    security_rule {
        name = "rule-2"
        priority = 102
        direction = "Outbound"
        access = "Allow"
        protocol = "Tcp"
        source_address_prefix = "192.168.2.0/24"
        source_port_range = "*"
        destination_address_prefix = "*"
        destination_port_range = "3306"
    }
    
    security_rule {
        name = "ssh-rule-3"
        priority = 100
        direction = "Outbound"
        access = "Deny"
        protocol = "Tcp"
        source_address_prefix = "192.168.1.0/24"
        source_port_range = "*"
        destination_address_prefix = "*"
        destination_port_range = "3306"
    }
}

resource "azurerm_subnet_network_security_group_association" "db-nsg-subnet" {
  subnet_id                 = var.db_subnet_id
  network_security_group_id = azurerm_network_security_group.db-nsg.id
}
