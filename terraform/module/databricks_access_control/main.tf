resource "databricks_catalog" "this" {
  name = var.catalog_name
}

resource "databricks_grants" "catalog" {
  catalog = databricks_catalog.this.name

  dynamic "grant" {
    for_each = var.catalog_access
    content {
      principal  = grant.key
      privileges = grant.value
    }
  }
}

resource "databricks_schema" "this" {
  for_each    = toset(var.schema_names)
  name        = each.key
  catalog_name = databricks_catalog.this.name
}

resource "databricks_grants" "schema" {
  for_each = var.schema_access

  schema = databricks_schema[each.key].name
  catalog = databricks_catalog.this.name

  dynamic "grant" {
    for_each = each.value
    content {
      principal  = grant.key
      privileges = grant.value
    }
  }
}
