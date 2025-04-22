provider "databricks" {
  alias = "workspace"
}

resource "databricks_grants" "catalog_grants" {
  for_each = var.catalogs
  catalog  = each.key

  dynamic "grant" {
    for_each = each.value.catalog_access
    content {
      principal  = grant.key
      privileges = grant.value
    }
  }
}

resource "databricks_grants" "schema_grants" {
  for_each = {
    for catalog_key, catalog_value in var.catalogs :
    for schema_name in catalog_value.schema_names :
    "${catalog_key}.${schema_name}" => {
      catalog_name = catalog_key
      schema_name  = schema_name
      grants       = lookup(catalog_value.schema_access, schema_name, {})
    }
  }

  catalog = each.value.catalog_name
  schema  = each.value.schema_name

  dynamic "grant" {
    for_each = each.value.grants
    content {
      principal  = grant.key
      privileges = grant.value
    }
  }
}