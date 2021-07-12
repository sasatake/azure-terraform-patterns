output "vm_private_key" {
  value = tls_private_key.vm_basic_app.private_key_pem
}

output "vm_name" {
  value = azurerm_linux_virtual_machine.vm_basic_app.name
}

output "public_ip_address" {
  value = azurerm_public_ip.vm_basic_app.ip_address
}

