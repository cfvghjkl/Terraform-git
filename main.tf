terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.0.1"
    }
  }
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "Storage" {
  name     = "Storage"
  location = "East US"  
}

resource "azurerm_storage_account" "storage_pratice" {
  name                     = "storagepratice"
  resource_group_name      = azurerm_resource_group.Storage.name
  location                 = azurerm_resource_group.Storage.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
