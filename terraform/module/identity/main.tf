# Define the required provider
terraform {
  required_providers {
    databricks = {
      source = "hashicorp/databricks"
      configuration_aliases = [
        "databricks.workspace",  # Reference the alias used in the root module
      ]
    }
  }
}

resource "azurerm_user_assigned_identity" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
}
