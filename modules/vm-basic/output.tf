output "vm_private_key" {
  value = tls_private_key.vm_basic_app.private_key_pem
}

output "vm_private_key_name" {
  value = "${azurerm_linux_virtual_machine.vm_basic_app.name}.id_rsa.pem"
}

