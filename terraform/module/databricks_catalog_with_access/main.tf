terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
      configuration_aliases = [databricks] 
    }
  }
}

resource "databricks_catalog" "this" {
  for_each     = var.catalog_definitions
  name         = each.key
  storage_root = each.value.storage_root
  comment      = "Catalog provisioned via Terraform"
}

resource "databricks_schema" "this" {
  for_each = merge([
    for catalog_name, catalog_def in var.catalog_definitions : {
      for schema_name in catalog_def.schema_names :
      "${catalog_name}.${schema_name}" => {
        catalog_name = catalog_name
        schema_name  = schema_name
      }
    }
  ]...)

  name         = each.value.schema_name
  catalog_name = each.value.catalog_name
  comment      = "Schema ${each.value.schema_name} in catalog ${each.value.catalog_name}"
}

resource "databricks_grants" "catalog" {
  for_each = var.catalog_definitions

  catalog = databricks_catalog.this[each.key].name

  dynamic "grant" {
    for_each = each.value.catalog_access
    content {
      principal  = grant.key
      privileges = grant.value
    }
  }
}

resource "databricks_grants" "schema" {
  for_each = merge([
    for catalog_name, catalog_def in var.catalog_definitions : {
      for schema_name, group_access in catalog_def.schema_access :
      "${catalog_name}.${schema_name}" => {
        catalog_name  = catalog_name
        schema_name   = schema_name
        group_access  = group_access
      }
    }
  ]...)

  schema       = databricks_schema["${each.value.catalog_name}.${each.value.schema_name}"].name
  catalog_name = each.value.catalog_name

  dynamic "grant" {
    for_each = each.value.group_access
    content {
      principal  = grant.key
      privileges = grant.value
    }
  }
}
