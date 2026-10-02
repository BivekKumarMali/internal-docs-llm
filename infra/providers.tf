terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
  }

  cloud {
    
    organization = "master-ai"

    workspaces {
      name = "internal-docs-llm-infra-dev"
    }
  }
}

provider "azurerm" {
  features {}
}