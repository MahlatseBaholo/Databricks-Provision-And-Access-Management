terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
      configuration_aliases = [databricks]
    }
  }
}

resource "databricks_grants" "schema" {
  for_each = { for schema in var.schema_names : schema => schema }

  catalog = var.catalog_name
  schema  = each.key   # <-- use each.key, not each.value

  dynamic "grant" {
    for_each = lookup(var.schema_access, each.key, {})
    content {
      principal  = grant.key
      privileges = grant.value
    }
  }
}



