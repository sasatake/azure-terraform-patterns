terraform {
  required_version = "~> 1.1.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform-state-manager-rg"
    storage_account_name = "terraformstatemng"
    container_name       = "tfstate"
    key                  = "functions-java/terraform.tfstate"
  }
}
