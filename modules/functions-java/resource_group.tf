resource "azurerm_resource_group" "functions_java" {
  name     = "${var.prefix}-rg"
  location = var.region
  tags     = local.default_tag
}

