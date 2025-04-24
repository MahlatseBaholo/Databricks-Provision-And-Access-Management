terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
      configuration_aliases = [databricks]
    }
  }
}

data "databricks_schemas" "all" {
  catalog_name = var.catalog_name
}

resource "databricks_grants" "schema" {
  for_each = var.schema_access

  schema = each.key
  catalog = var.catalog_name

  dynamic "grant" {
    for_each = each.value
    content {
      principal  = grant.key
      privileges = grant.value
    }
  }

  depends_on = [data.databricks_schemas.all]
}
