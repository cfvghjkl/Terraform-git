terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.1.0"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = "8a794a34-9f1e-4bd1-8f73-1e519883c37a"
  tenant_id = "7fc18fde-694b-4a36-b13a-5b4e645a411c"
  client_id = "c60b3a0f-89c7-40bf-a33c-5e4e9fbb2b32"
}

resource "azurerm_resource_group" "SV" {
  name     = "sagarika-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "sagarika-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.SV.location
  resource_group_name = azurerm_resource_group.SV.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.SV.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "svinterface" {
  name                = "sagarika-nic"
  location            = azurerm_resource_group.SV.location
  resource_group_name = azurerm_resource_group.SV.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "sagarika" {
  name                = "machine"
  resource_group_name = azurerm_resource_group.SV.name
  location            = azurerm_resource_group.SV.location
  size                = "Standard_F2"
  admin_username      = "sagarika"
  admin_password      = "Sagarika@123"
  network_interface_ids = [
    azurerm_network_interface.svinterface.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
