provider "azurerm" {
  features {}
}

module "vm_basic" {
  source      = "../../modules/vm-basic/"
  main_region = var.main_region
}

resource "local_file" "tls_private_key" {
  content         = module.vm_basic.vm_private_key
  filename        = "${path.module}/${module.vm_basic.vm_private_key_name}"
  file_permission = "0600"
}
