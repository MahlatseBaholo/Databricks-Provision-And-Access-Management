locals {
  storage_definitions = {
    for catalog_name, _ in var.catalog_definitions : catalog_name => {
      container_name          = catalog_name
      storage_credential_name = "sasoleuw-aes-dbsc-${catalog_name}"
      external_location_name  = "${catalog_name}-catalog-external-location"
    }
  }

  enriched_catalog_definitions = {
    for catalog_name, def in var.catalog_definitions : catalog_name => merge(def, {
      storage_root = module.external_location[catalog_name].external_location_url
    })
  }
}

module "databricks_catalog_schema_grants" {
  source        = "./module/databricks_catalog_schema_grants"
  for_each      = local.enriched_catalog_definitions
  catalog_name  = each.key
  schema_access = each.value.schema_access
  providers = {
    databricks = databricks.workspace
  }
}
