terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.91.0"
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = var.azure_rg_name
  location = var.azure_location_vara
}