module "databricks_catalog_schema_grants" {
  source        = "./module/databricks_catalog_schema_grants"
  for_each      = local.enriched_catalog_definitions
  catalog_name  = each.key
  schema_access = each.value.schema_access
  providers = {
    databricks = databricks.workspace
  }
}
