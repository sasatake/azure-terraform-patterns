resource "azurerm_cosmosdb_account" "functions_java" {
  name                = "${var.prefix}-db"
  resource_group_name = azurerm_resource_group.functions.name
  location            = var.region
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  enable_automatic_failover = false

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = var.region
    failover_priority = 0
  }

  tags = locals.default_tag
}
