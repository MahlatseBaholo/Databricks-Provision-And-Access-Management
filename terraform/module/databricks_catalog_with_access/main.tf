terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
      configuration_aliases = [databricks] 
    }
  }
}

resource "time_sleep" "wait_for_schema" {
  for_each = var.schema_access

  depends_on = [databricks_schema.this]

  create_duration = "15s"  # wait 15 seconds before proceeding
}

resource "databricks_catalog" "this" {
  name         = var.catalog_name
  storage_root = var.storage_root
  comment      = "Catalog provisioned via Terraform"
}

resource "databricks_schema" "this" {
  for_each = {
    for schema_name in var.schema_names :
    schema_name => schema_name
  }

  name         = each.value
  catalog_name = var.catalog_name
  comment      = "Schema ${each.value} in catalog ${var.catalog_name}"

  depends_on = [databricks_catalog.this]
}

resource "databricks_grants" "catalog" {
  catalog = var.catalog_name

  dynamic "grant" {
    for_each = var.catalog_access
    content {
      principal  = grant.key
      privileges = grant.value
    }
  }

  depends_on = [databricks_catalog.this]
}

resource "databricks_grants" "schema" {
  for_each = var.schema_access

  schema = databricks_schema.this[each.key].name  # Ensure this references the schema by name
  dynamic "grant" {
    for_each = each.value
    content {
      principal  = grant.key
      privileges = grant.value
    }
  }

  depends_on = [
    databricks_schema.this,     # Wait for schema creation
    databricks_catalog.this,
    time_sleep.wait_for_schema,     # Wait for catalog creation
  ]
}

