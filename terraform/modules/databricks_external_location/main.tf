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
  for_each = local.storage_definitions

  external_location = module.external_location[each.key].name

  dynamic "grant" {
    content {
      principal  = "SIMEGAS-ADMIN"
      privileges = ["READ_EXTERNAL_LOCATION_METADATA"]
    }
  }
}