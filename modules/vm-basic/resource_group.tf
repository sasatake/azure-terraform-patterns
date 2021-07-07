resource "azurerm_resource_group" "vm_basic" {
  name     = "vm-basic-rg"
  location = var.main_region
  tags = {
    createdBy = "Terraform"
    module = "vm-basic"
  }
}
