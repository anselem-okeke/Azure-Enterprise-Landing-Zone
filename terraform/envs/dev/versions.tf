terraform {
  required_version = ">= 1.6.0"

    backend "azurerm" {
    resource_group_name  = "rg-tfstate-dev"
    storage_account_name = "sttfstateanselemdev01"
    container_name       = "tfstate"
    key                  = "azure-enterprise-landing-zone/dev.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}
