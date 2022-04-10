resource "azurerm_resource_group" "functions_java" {
  name     = "${var.prefix}-rg"
  location = var.main_region
  tags     = locals.default_tag
}

