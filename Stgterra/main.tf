terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  client_id       = "a199abdb-2b54-43c3-bd16-8238bd6bd609"
  client_secret   = "E4c8Q~NytUmjTwjcxkn2X.8GZUVaTl.iCicjac-4"
  tenant_id       = "0b1a30a8-c566-46bf-b940-ffe0332fcbf6"
  subscription_id = "f35670df-f099-4bc3-82eb-e30c7229dade"
}

terraform {
  backend "azurerm" {
    resource_group_name  = "rgmainisro"
    storage_account_name = "stgmaininfra"
    container_name       = "stgcontainerinfra"
    key                  = "landingzone.tfstate"
    access_key           = "L2MIIPX1WSg/DBy6tycg4AY9FyHgr9FTyQn1BKkLBEny4Ll64uBzAPw4Jsp/v+jV/l+p+n6iVK+i+ASt3hFDGw=="
  }
}

resource "azurerm_resource_group" "rg" {
  
  name     = "rgmainisro"
  location = "eastus"
}

resource "azurerm_app_service" "web_app" {
  name                = "streaming_web_app"
  location            = "eastus"
  resource_group_name = "rgmainisro"

sku {
  tier = "Free"
  size = "F1"
}
}

rsource "azurerm_virtual_network" "vnet" {
  name = "vnet"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space = ["10.10.1.0"]
}


