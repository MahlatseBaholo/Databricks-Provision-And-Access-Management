terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
      configuration_aliases = [databricks]
    }
  }
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
  depends_on = [
    module.databricks_catalog_with_access  # Ensure the catalog and schema exist before applying grants
  ]
}
