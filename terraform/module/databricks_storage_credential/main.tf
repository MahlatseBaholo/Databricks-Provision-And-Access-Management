# Define the required provider
terraform {
  required_providers {
    databricks = {
      source = "hashicorp/databricks"
      configuration_aliases = [
        "databricks.workspace"  # Reference the alias used in the root module
      ]
    }
  }
}


resource "databricks_storage_credential" "this" {
  provider = databricks.workspace
  name     = var.name

  azure_managed_identity {
    access_connector_id = var.access_connector_id
    managed_identity_id = var.managed_identity_id
  }
}
