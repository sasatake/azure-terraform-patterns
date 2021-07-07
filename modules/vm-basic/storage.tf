resource "random_id" "randomId" {
  keepers = {
    resource_group = azurerm_resource_group.vm_basic.name
  }
  byte_length = 8
}


resource "azurerm_storage_account" "vm_basic" {
  name                     = "vmbasic${random_id.randomId.hex}"
  resource_group_name      = azurerm_resource_group.vm_basic.name
  location                 = azurerm_resource_group.vm_basic.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  tags = {
    createdBy = "Terraform"
    module = "vm-basic"
  }
}
