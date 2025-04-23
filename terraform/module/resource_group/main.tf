terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      configuration_aliases = [databricks.azure_account]
    }
  }
}

resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location
}
