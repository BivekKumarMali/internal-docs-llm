terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.6"
    }
    time = {
      source  = "hashicorp/time"
      version = "~>0.12"
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
