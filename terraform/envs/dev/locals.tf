locals {
  storage_definitions = {
    for catalog_name, catalog_def in var.catalog_definitions : "${catalog_name}-${var.env}" => {
      container_name          = "${catalog_name}${var.env}"
      storage_credential_name = "sasol${var.location_abbr}-${catalog_def.project}-dbsc-${catalog_name}-${var.env}"
      external_location_name  = "${catalog_name}-${var.env}-catalog-external-location"
    }
  }

  enriched_catalog_definitions = {
    for catalog_name, def in var.catalog_definitions : "${catalog_name}-${var.env}" => {
      schema_names   = def.schema_names
      catalog_access = def.catalog_access
      schema_access  = lookup(def, "schema_access", {})
      storage_root   = module.external_location["${catalog_name}-${var.env}"].external_location_url
    }
  }
}
