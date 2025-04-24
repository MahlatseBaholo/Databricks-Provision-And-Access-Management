terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
      configuration_aliases = [databricks.workspace] 
    }
  }
}

resource "databricks_catalog" "this" {
  name         = var.catalog_name
  comment      = "Managed via Terraform"
  storage_root = var.storage_root
  provider     = databricks.workspace
}

resource "databricks_schema" "this" {
  for_each     = toset(var.schema_names)
  name         = each.key
  catalog_name = databricks_catalog.this.name
  comment      = "Schema ${each.key}"
  provider     = databricks.workspace
}

# Grant catalog-level permissions
resource "databricks_grants" "catalog_grants" {
  catalog = databricks_catalog.this.name

  dynamic "grant" {
    for_each = var.catalog_access
    content {
      principal  = grant.key
      privileges = grant.value
    }
  }
}

# Grant schema-level permissions
resource "databricks_grants" "schema_grants" {
  for_each = var.schema_access

  schema  = databricks_schema[each.key].name
  catalog = databricks_catalog.this.name

  dynamic "grant" {
    for_each = each.value
    content {
      principal  = grant.key
      privileges = grant.value
    }
  }
}
