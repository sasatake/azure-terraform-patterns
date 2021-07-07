resource "azurerm_virtual_network" "vm_basic" {
  name                = "vnet-vm_basic"
  address_space       = var.virtual_network_address_spaces
  location            = azurerm_resource_group.vm_basic.location
  resource_group_name = azurerm_resource_group.vm_basic.name
  tags = {
    createdBy = "Terraform"
    module    = "vm-basic"
  }
}

resource "azurerm_subnet" "vm_basic" {
  count = length(var.subnet_address_prefixes)

  name                 = "snet-vm_basic-${count.index}"
  resource_group_name  = azurerm_resource_group.vm_basic.name
  virtual_network_name = azurerm_virtual_network.vm_basic.name
  address_prefixes     = [var.subnet_address_prefixes[count.index]]
}

resource "azurerm_network_interface" "vm_basic_app" {
  name                = "nic-vm_basic_app"
  location            = azurerm_resource_group.vm_basic.location
  resource_group_name = azurerm_resource_group.vm_basic.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm_basic[0].id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    createdBy = "Terraform"
    module    = "vm-basic"
  }
}
