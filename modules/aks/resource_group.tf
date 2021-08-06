resource "azurerm_resource_group" "aks_test" {
  name     = "aks-test-rg"
  location = var.main_region
  tags = {
    createdBy = "Terraform"
    module = "aks"
  }
}

