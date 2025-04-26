locals {
  schema_grant_definitions = {
    for catalog_name, schema_data in data.databricks_schemas.schemas : catalog_name => {
      schema_names  = schema_data.schemas[*].name
      schema_access = var.catalog_definitions[catalog_name].schema_access
    }
  }
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

