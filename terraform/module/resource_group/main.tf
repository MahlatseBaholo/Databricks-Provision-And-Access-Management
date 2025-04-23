terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
      configuration_aliases = [databricks.azure_account]
    }
  }
}

resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location
}
