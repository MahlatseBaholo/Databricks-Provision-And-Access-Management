terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
      configuration_aliases = [databricks]
    }
  }
}

resource "databricks_grants" "schema" {
  for_each = toset(var.schema_names)

  schema  = each.value
  catalog = var.catalog_name

  dynamic "grant" {
    for_each = lookup(var.schema_access, each.value, {})
    content {
      principal  = grant.key
      privileges = grant.value
    }
  }
}


