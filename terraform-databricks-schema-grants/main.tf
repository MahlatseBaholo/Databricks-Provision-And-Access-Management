locals {
  schema_grant_definitions = {
    for catalog_name, schema_data in data.terraform_remote_state.metastore.outputs.catalog_schemas : catalog_name => {
      schema_names = [
        for id in schema_data.ids : regex("^${catalog_name}\\.(.*)$", id)[0]
        if !endswith(id, "information_schema")
      ]
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