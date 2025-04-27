locals {
  schema_grant_definitions = var.catalog_definitions
}

module "databricks_catalog_schema_grants" {
  source = "./module/databricks_catalog_schema_grants"
  for_each = local.schema_grant_definitions

  catalog_name  = each.key
  schema_names  = each.value.schema_names
  schema_access = each.value.schema_access

  providers = {
    databricks = databricks.workspace
  }
}
