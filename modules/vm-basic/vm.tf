resource "tls_private_key" "vm_basic_app" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_linux_virtual_machine" "vm_basic_app" {
  name                = "vmbasicapp000"
  resource_group_name = azurerm_resource_group.vm_basic.name
  location            = azurerm_resource_group.vm_basic.location
  size                = "Standard_B1ls"
  network_interface_ids = [
    azurerm_network_interface.vm_basic_app.id,
  ]

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "osdisk-vmbasicapp000"
    disk_size_gb         = 30
  }

  admin_username = var.admin_user_name
  admin_ssh_key {
    username   = var.admin_user_name
    public_key = tls_private_key.vm_basic_app.public_key_openssh
  }
  disable_password_authentication = true

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.vm_basic.primary_blob_endpoint
  }
  
  custom_data = filebase64("${path.module}/templates/vm/cloud-config.yml")

  tags = {
    createdBy = "Terraform"
    module    = "vm-basic"
  }
}

resource "azurerm_managed_disk" "vm_basic_app" {
  name                 = "disk-${azurerm_linux_virtual_machine.vm_basic_app.name}-001"
  resource_group_name  = azurerm_resource_group.vm_basic.name
  location             = azurerm_resource_group.vm_basic.location
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}

resource "azurerm_virtual_machine_data_disk_attachment" "vm_basic_app" {
  managed_disk_id    = azurerm_managed_disk.vm_basic_app.id
  virtual_machine_id = azurerm_linux_virtual_machine.vm_basic_app.id
  lun                = "10"
  caching            = "ReadWrite"
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "vm_basic_app" {
  virtual_machine_id    = azurerm_linux_virtual_machine.vm_basic_app.id
  location              = azurerm_resource_group.vm_basic.location
  enabled               = true
  daily_recurrence_time = "1900"
  timezone              = "Tokyo Standard Time"

  notification_settings {
    enabled = false
  }
}

