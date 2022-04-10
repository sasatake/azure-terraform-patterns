resource "azurerm_application_insights" "functions_java" {
  name                = "${var.prefix}-insights"
  resource_group_name = azurerm_resource_group.functions.name
  location            = var.region
  application_type    = "Web"
  tags                = locals.default_tag
}
