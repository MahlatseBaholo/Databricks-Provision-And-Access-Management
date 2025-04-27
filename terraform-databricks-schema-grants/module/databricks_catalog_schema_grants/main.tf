terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
      configuration_aliases = [databricks]
    }
  }
}

resource "databricks_grants" "schema" {
  for_each = toset(var.schema_names)  # Loop over schemas in the catalog

  schema  = each.value                # Specify the schema name
  catalog = var.catalog_name          # Specify the catalog name

  dynamic "grant" {
    for_each = lookup(var.schema_access, each.value, {})
    content {
      principal  = grant.key
      privileges = grant.value
    }
  }
}


