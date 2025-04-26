data "databricks_schemas" "schemas" {
  for_each = local.enriched_catalog_definitions
  catalog_name = each.key

  depends_on = [
    module.databricks_catalog_with_access
  ]

  provider = databricks.workspace
}
