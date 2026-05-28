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

  cluster_base_token = "multi-node-aes2"

  cluster_suffix_default = "small-general-purpose"

  cluster_definitions = {
    for unit_name, unit_def in var.unit_definitions : unit_name => {
      cluster_name = "${var.env}-${unit_name}-${local.cluster_base_token}-${local.cluster_suffix_default}"

      spark_version           = unit_def.cluster.spark_version
      node_type_id            = unit_def.cluster.node_type_id
      driver_node_type_id     = try(unit_def.cluster.driver_node_type_id, unit_def.cluster.node_type_id)
      autotermination_minutes = try(unit_def.cluster.autotermination_minutes, 10)
      azure_attributes = {
        first_on_demand    = try(unit_def.cluster.azure_attributes.first_on_demand, 1)
        availability       = try(unit_def.cluster.azure_attributes.availability, "SPOT_WITH_FALLBACK_AZURE")
        spot_bid_max_price = try(unit_def.cluster.azure_attributes.spot_bid_max_price, -1)
      }
      autoscale          = try(unit_def.cluster.autoscale, null)
      data_security_mode = try(unit_def.cluster.data_security_mode, "USER_ISOLATION")

      cluster_permissions = unit_def.cluster.cluster_permissions
    }
  }

  sql_warehouse_definitions = {
    for unit_name, unit_def in var.unit_definitions : unit_name => {
      sql_warehouse_name                = "${var.env}-${unit_name}-${try(unit_def.sql_warehouse.name_suffix, "serverless-sql-warehouse-aes2-small")}"
      sql_warehouse_cluster_size        = try(unit_def.sql_warehouse.cluster_size, "Small")
      sql_warehouse_max_num_clusters    = try(unit_def.sql_warehouse.max_num_clusters, 1)
      sql_warehouse_min_num_clusters    = try(unit_def.sql_warehouse.min_num_clusters, 1)
      sql_warehouse_auto_stop_mins      = try(unit_def.sql_warehouse.auto_stop_mins, 10)
      sql_warehouse_enable_serverless_compute = try(unit_def.sql_warehouse.enable_serverless_compute, true)
      sql_warehouse_tags               = try(unit_def.sql_warehouse.tags, {})
      warehouse_type                   = try(unit_def.sql_warehouse.warehouse_type, "PRO")

      sql_warehouse_enable_permissions = try(unit_def.sql_warehouse.enable_permissions, false)
      sql_warehouse_permissions        = try(unit_def.sql_warehouse.permissions, [])
      enabled                          = try(unit_def.sql_warehouse.enabled, false)
    }
  }
}
