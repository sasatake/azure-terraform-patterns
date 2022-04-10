resource "azurerm_application_insights" "functions_java" {
  name                = "${var.prefix}-insights"
  resource_group_name = azurerm_resource_group.functions_java.name
  location            = var.region
  application_type    = "web"
  tags                = local.default_tag
}
