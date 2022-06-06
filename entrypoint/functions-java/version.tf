terraform {
  required_version = "~> 1.2.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.9.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform-state-manager-rg"
    storage_account_name = "terraformstatemng"
    container_name       = "tfstate"
    key                  = "functions-java/terraform.tfstate"
    use_oidc             = true
  }
}
