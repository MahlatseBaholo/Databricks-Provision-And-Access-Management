terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
      configuration_aliases = [databricks]
    }
  }
}

resource "databricks_external_location" "this" {
  name            = var.name
  url             = var.url
  credential_name = var.credential_name
}

resource "databricks_grants" "external_location_read" {
  count               = var.read_group != null ? 1 : 0
  external_location   = databricks_external_location.this.id
  grant {
    principal  = var.read_group
    privileges = ["READ_FILES"]
  }
}
