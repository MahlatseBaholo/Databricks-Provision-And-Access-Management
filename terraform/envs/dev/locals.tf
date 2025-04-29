locals {
  storage_definitions = {
    for catalog_name, catalog_def in var.catalog_definitions : catalog_name => {
      container_name          = catalog_name
      storage_credential_name = "sasoleuw-${catalog_def.project}-dbsc-${catalog_name}"
      external_location_name  = "${catalog_name}-catalog-external-location"
    }
  }

  enriched_catalog_definitions = {
    for catalog_name, def in var.catalog_definitions : catalog_name => {
      schema_names   = def.schema_names
      catalog_access = def.catalog_access
      schema_access  = lookup(def, "schema_access", {})
      storage_root   = module.external_location[catalog_name].external_location_url
    }
  }
}