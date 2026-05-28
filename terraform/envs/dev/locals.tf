locals {
  storage_definitions = {
    for catalog_name, catalog_def in var.catalog_definitions : "${var.env}-${catalog_name}" => {
      container_name          = "${var.env}-${catalog_name}"
      storage_credential_name = "${var.env}-${catalog_def.project}-dbsc-${catalog_name}"
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

locals {
  ##############################################
  # Defaults (applied if unit does not specify)
  ##############################################
  cluster_defaults = {
    spark_version           = "15.4.x-scala2.12"
    node_type_id            = "Standard_DS3_v2"
    driver_node_type_id     = "Standard_DS3_v2"
    autotermination_minutes = 10
    data_security_mode      = "USER_ISOLATION"

    azure_attributes = {
      first_on_demand    = 1
      availability       = "SPOT_WITH_FALLBACK_AZURE"
      spot_bid_max_price = -1
    }

    autoscale = {
      min_workers = 2
      max_workers = 10
    }
  }

  cluster_definitions = merge([
    for unit_name, unit_def in var.unit_definitions : {
      for profile_name, profile_def in unit_def.clusters :
      "${var.env}-${unit_name}-${profile_name}" => {
        unit         = unit_name
        profile      = profile_name

        # Naming standard
        cluster_name = "${var.env}-${unit_name}-multi-node-aes2-${profile_name}-general-purpose"

        # Resolve each attribute: unit override -> defaults
        spark_version           = coalesce(try(profile_def.spark_version, null), local.cluster_defaults.spark_version)
        node_type_id            = coalesce(try(profile_def.node_type_id, null), local.cluster_defaults.node_type_id)
        driver_node_type_id     = coalesce(try(profile_def.driver_node_type_id, null), local.cluster_defaults.driver_node_type_id)
        autotermination_minutes = coalesce(try(profile_def.autotermination_minutes, null), local.cluster_defaults.autotermination_minutes)
        data_security_mode      = coalesce(try(profile_def.data_security_mode, null), local.cluster_defaults.data_security_mode)

        azure_attributes = {
          first_on_demand    = coalesce(try(profile_def.azure_attributes.first_on_demand, null), local.cluster_defaults.azure_attributes.first_on_demand)
          availability       = coalesce(try(profile_def.azure_attributes.availability, null), local.cluster_defaults.azure_attributes.availability)
          spot_bid_max_price = coalesce(try(profile_def.azure_attributes.spot_bid_max_price, null), local.cluster_defaults.azure_attributes.spot_bid_max_price)
        }

        autoscale = {
          min_workers = coalesce(try(profile_def.autoscale.min_workers, null), local.cluster_defaults.autoscale.min_workers)
          max_workers = coalesce(try(profile_def.autoscale.max_workers, null), local.cluster_defaults.autoscale.max_workers)
        }
      }
    }
  ]...)


  sql_warehouse_definitions = {
    for unit_name, unit_def in var.unit_definitions :
    "${var.env}-${unit_name}" => {
      warehouse_name = "${var.env}-${unit_name}-${try(unit_def.sql_warehouse.name_suffix, "serverless-sql-warehouse-aes2-small")}"

      cluster_size              = try(unit_def.sql_warehouse.cluster_size, "2X-Small")
      max_num_clusters          = try(unit_def.sql_warehouse.max_num_clusters, 2)
      min_num_clusters          = try(unit_def.sql_warehouse.min_num_clusters, 1)
      auto_stop_mins            = try(unit_def.sql_warehouse.auto_stop_mins, 10)
      enable_serverless_compute = try(unit_def.sql_warehouse.enable_serverless_compute, false)
      enable_permissions        = try(unit_def.sql_warehouse.enable_permissions, true)
      warehouse_type            = try(unit_def.sql_warehouse.warehouse_type, "Serverless")
    }
    if can(unit_def.sql_warehouse)
  }
}
