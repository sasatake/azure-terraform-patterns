provider "azurerm" {
  features {}
}

module "aks" {
  source          = "../../modules/aks/"
  main_region     = var.main_region
}

resource "local_file" "kube_config" {
  filename        = "${path.module}/${module.aks.cluster_name}_kube_config"
  content         = module.aks.kube_config
}
