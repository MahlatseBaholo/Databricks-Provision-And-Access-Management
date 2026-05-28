locals {
  storage_definitions = {
    for catalog_name, catalog_def in var.catalog_definitions : "${var.env}-${catalog_name}" => {
      container_name          = "${var.env}-${catalog_name}"
      storage_credential_name = "sasol${var.location_abbr}-${var.env}-${catalog_def.project}-dbsc-${catalog_name}"
      external_location_name  = "${var.env}-${catalog_name}-catalog-external-location"
    }
  }

  enriched_catalog_definitions = {
    for catalog_name, def in var.catalog_definitions : "${var.env}-${catalog_name}" => {
      schema_names   = def.schema_names
      catalog_access = def.catalog_access
      schema_access  = lookup(def, "schema_access", {})
      storage_root   = module.external_location["${var.env}-${catalog_name}"].external_location_url
    }
  }
}
