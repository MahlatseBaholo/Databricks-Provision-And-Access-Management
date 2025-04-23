terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~>1.5"
    }
  }
}

resource "databricks_external_location" "this" {
  provider        = databricks.workspace
  name            = var.name
  url             = var.url
  credential_name = var.credential_name
  comment         = var.comment
}
