
terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.104"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "679f3d56-bed2-429f-9e31-4d7bf67e14c7"
}

# Use existing Resource Group
data "azurerm_resource_group" "rg" {
  name = "Sanskriti_Mahendra_RG"
}

# Random suffix for unique storage account name
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  lower   = true
  numeric = true
  special = false
}

# Storage Account (public access enabled for simplicity)
resource "azurerm_storage_account" "lab2_sa" {
  name                     = "sanskritilab2${random_string.suffix.result}"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version                   = "TLS1_2"
  allow_nested_items_to_be_public   = false

  # ✅ Enable public network access so Terraform can create resources without error
  public_network_access_enabled     = true

  # Optional network rules
  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]
    ip_rules       = []
  }

  tags = {
    lab   = "lab2"
    owner = "Sanskriti Mahendra"
  }
}
