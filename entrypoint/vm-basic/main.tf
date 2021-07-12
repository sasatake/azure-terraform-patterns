provider "azurerm" {
  features {}
}

module "vm_basic" {
  source          = "../../modules/vm-basic/"
  main_region     = var.main_region
  admin_user_name = var.admin_user_name
}

resource "local_file" "tls_private_key" {
  filename        = "${path.module}/${module.vm_basic.vm_name}.id_rsa.pem"
  content         = module.vm_basic.vm_private_key
  file_permission = "0600"
}

resource "local_file" "ssh_alias" {
  filename = "${path.module}/ssh_alias.${module.vm_basic.vm_name}.sh"
  content = templatefile("${path.module}/templates/ssh_alias.sh.tpl", {
    secret = local_file.tls_private_key.filename
    user   = var.admin_user_name
    host   = module.vm_basic.public_ip_address
  })
  file_permission = "0555"
}
