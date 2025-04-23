terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
      configuration_aliases = [databricks.workspace] 
    }
  }
}

resource "databricks_external_location" "this" {
  provider        = databricks.workspace
  name            = var.name
}
