terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.21.1"
    }
    
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.63.0"
    }
  }

  required_version = ">= 1.2.0"
}


