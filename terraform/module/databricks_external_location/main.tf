terraform {
  required_providers {
    databricks = {
      #source = "databricks/databricks"
      configuration_aliases = [databricks.workspace] 
    }
  }
}

resource "databricks_external_location" "this" {
  name            = var.name
  url             = var.url
  credential_name = var.credential_name
}
