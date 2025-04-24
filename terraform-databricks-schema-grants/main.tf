module "databricks_catalog_schema_grants" {
  for_each = var.catalog_definitions 

  source        = "./module/databricks_catalog_schema_grants"
  catalog_name  = each.key
  schema_access = each.value.schema_access

  providers = {
    databricks = databricks.workspace
  }
}
