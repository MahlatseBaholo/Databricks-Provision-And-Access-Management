resource "databricks_catalog_permission" "catalog_access" {
  catalog = var.catalog_name
  dynamic "grant" {
    for_each = var.catalog_access
    content {
      principal = grant.key
      privileges = grant.value
    }
  }
}

resource "databricks_schema_permission" "schema_access" {
  for_each = var.schema_access
  catalog = var.catalog_name
  schema  = each.key
  dynamic "grant" {
    for_each = each.value
    content {
      principal = grant.key
      privileges = grant.value
    }
  }
}
