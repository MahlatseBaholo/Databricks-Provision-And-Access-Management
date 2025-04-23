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

resource "databricks_external_location" "this" {
  name            = var.name
  url             = var.url
  credential_name = var.credential_name
  comment         = var.comment

  depends_on = [var.depends_on]
}
