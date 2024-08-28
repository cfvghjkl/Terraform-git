terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.0.1"
    }
  }
}
provider azurerm {
  features {}
}

resource "azurerm_resource_group" "resource_storage" {
  name     = "resource_storage"
  location = "West Europe"
}

resource "azurerm_storage_account" "storage_pratice" {
  name                     = "terraformstorageaccount11"
  resource_group_name      = azurerm_resource_group.resource_storage.name
  location                 = azurerm_resource_group.resource_storage.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
