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

# For vm_basic_app settings

resource "azurerm_public_ip" "vm_basic_app" {
  name                = "pip-vm_basic_app"
  location            = azurerm_resource_group.vm_basic.location
  resource_group_name = azurerm_resource_group.vm_basic.name
  sku                 = "Basic"
  allocation_method   = "Static"

  tags = {
    createdBy = "Terraform"
    module    = "vm-basic"
  }
}

resource "azurerm_network_interface" "vm_basic_app" {
  name                = "nic-vm_basic_app"
  location            = azurerm_resource_group.vm_basic.location
  resource_group_name = azurerm_resource_group.vm_basic.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm_basic[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_basic_app.id
  }

  tags = {
    createdBy = "Terraform"
    module    = "vm-basic"
  }
}

resource "azurerm_network_security_group" "vm_basic_app" {
  name                = "nsg-vm_basic_app"
  location            = azurerm_resource_group.vm_basic.location
  resource_group_name = azurerm_resource_group.vm_basic.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    createdBy = "Terraform"
    module    = "vm-basic"
  }
}

resource "azurerm_network_interface_security_group_association" "vm_basic_app" {
  network_interface_id      = azurerm_network_interface.vm_basic_app.id
  network_security_group_id = azurerm_network_security_group.vm_basic_app.id
}
