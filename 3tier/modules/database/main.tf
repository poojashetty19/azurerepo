resource "azurerm_sql_server" "sqlserver" {
    name = var.databasename
    resource_group_name = var.rgname
    location = var.rglocation
    version = var.database_version
    administrator_login = var.database_username
    administrator_login_password = var.database_password
}

resource "azurerm_sql_database" "db" {
  name                = "db"
  resource_group_name = var.rgname
  location            = var.rglocation
  server_name         = azurerm_sql_server.sqlserver.name
}
