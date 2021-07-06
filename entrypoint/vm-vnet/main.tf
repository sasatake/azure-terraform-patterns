provider "azurerm" {
  features {}
}

module "vm-vnet" {
  source      = "../../modules/vm-vnet/"
  main_region = var.main_region
}
