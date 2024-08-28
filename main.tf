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

resource "azurerm_resource_group" "StorageApplication" {
  name     = "StorageApplication"
  location = "East US"  # Replace with your desired location
}

resource "azurerm_storage_account" "storage_pratice" {
  name                     = "storagepratice"
  resource_group_name      = azurerm_resource_group.StorageApplication.name
  location                 = azurerm_resource_group.StorageApplication.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
