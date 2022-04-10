resource "azurerm_storage_account" "functions_java" {
  name                     = "${replace(lower(var.prefix), "-", "")}data"
  resource_group_name      = azurerm_resource_group.functions_java.name
  location                 = var.region
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.default_tag
}
