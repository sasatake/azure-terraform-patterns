resource "azurerm_resource_group" "vm_vnet" {
  name     = "vm-vnet-rg"
  location = var.main_region
}
