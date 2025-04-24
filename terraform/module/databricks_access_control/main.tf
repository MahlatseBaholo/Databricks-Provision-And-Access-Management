locals {
  access = yamldecode(file("${path.module}/access.yaml"))
}

resource "databricks_catalog" "this" {
  name = var.catalog_name
}

resource "databricks_schema" "this" {
  for_each     = toset(local.access.schema_names)
  name         = each.key
  catalog_name = databricks_catalog.this.name
}

resource "databricks_grants" "catalog" {
  catalog     = databricks_catalog.this.name
  dynamic "grant" {
    for_each = local.access.catalog_access
    content {
      principal = grant.key
      privileges = grant.value
    }
  }
}

resource "databricks_grants" "schema" {
  for_each = {
    for schema, access in local.access.schema_access : schema => access
  }
  schema      = databricks_schema[each.key].name
  catalog     = databricks_catalog.this.name
  dynamic "grant" {
    for_each = each.value
    content {
      principal = grant.key
      privileges = grant.value
    }
  }
}
