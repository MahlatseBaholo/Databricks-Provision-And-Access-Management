locals {
  catalog_slug = {
    for catalog_name, def in var.catalog_definitions :
    catalog_name => replace(
      lower(replace(catalog_name, "-", "_")),
      "/[^a-z0-9_]/",
      ""
    )
  }

  container_slug_raw = {
    for catalog_name, def in var.catalog_definitions :
    catalog_name => replace(
      replace(
        lower(replace(local.catalog_slug[catalog_name], "_", "-")),
        "/[^a-z0-9-]/",
        ""
      ),
      "/-{2,}/",
      "-"
    )
  }

  container_slug = {
    for catalog_name, def in var.catalog_definitions :
    catalog_name => replace(
      replace(local.container_slug_raw[catalog_name], "/^-+/", ""),
      "/-+$/",
      ""
    )
  }

  storage_definitions = {
      for catalog_name, catalog_def in var.catalog_definitions :
      "${var.env}_${local.catalog_slug[catalog_name]}" => {
        # Generated names
        container_name          = "${var.env}-${local.container_slug[catalog_name]}"
        storage_credential_name = "${var.env}_${local.catalog_slug[catalog_name]}_dbsc"
        external_location_name  = "${var.env}_${local.catalog_slug[catalog_name]}_catalog_external_location"

        # Optional existing storage
        storage_account_name   = try(catalog_def.storage_account_name, null)
        storage_container_name = try(catalog_def.storage_container_name, null)
        storage_folder         = try(catalog_def.storage_folder, null)

        use_existing_storage = (
          try(catalog_def.storage_account_name, null) != null &&
          try(catalog_def.storage_container_name, null) != null
        )
      }
    }

    # Resources that Terraform must create
    new_storage_definitions = {
      for key, definition in local.storage_definitions :
      key => definition
      if !definition.use_existing_storage
    }

    # Resources that already exist
    existing_storage_definitions = {
      for key, definition in local.storage_definitions :
      key => definition
      if definition.use_existing_storage
    }

  enriched_catalog_definitions = {
    for catalog_name, def in var.catalog_definitions :
    "${var.env}_${local.catalog_slug[catalog_name]}" => {
      schema_names   = def.schema_names
      catalog_access = def.catalog_access
      schema_access  = lookup(def, "schema_access", {})
      storage_root   = module.external_location["${var.env}_${local.catalog_slug[catalog_name]}"].external_location_url
    }
  }

  cluster_definitions = {
    for unit_name, unit_def in var.unit_definitions : "${var.env}-${unit_name}" => {
      cluster_name = "${var.env}-${unit_name}-multi-node-aes2-${try(unit_def.cluster.size, "small")}-${try(unit_def.cluster.purpose, "general-purpose")}"

      spark_version           = unit_def.cluster.spark_version
      node_type_id            = unit_def.cluster.node_type_id
      driver_node_type_id     = try(unit_def.cluster.driver_node_type_id, unit_def.cluster.node_type_id)
      autotermination_minutes = try(unit_def.cluster.autotermination_minutes, 10)
      data_security_mode      = try(unit_def.cluster.data_security_mode, "USER_ISOLATION")

      azure_attributes = {
        first_on_demand    = try(unit_def.cluster.azure_attributes.first_on_demand, 1)
        availability       = try(unit_def.cluster.azure_attributes.availability, "SPOT_WITH_FALLBACK_AZURE")
        spot_bid_max_price = try(unit_def.cluster.azure_attributes.spot_bid_max_price, -1)
      }

      autoscale = try(unit_def.cluster.autoscale, null)

      cluster_permissions = try(unit_def.cluster.cluster_permissions, {})
    }
  }

  sql_warehouse_definitions = {
    for unit_name, unit_def in var.unit_definitions : "${var.env}-${unit_name}" => {
      name                      = "${var.env}-${unit_name}-${try(unit_def.sql_warehouse.name_suffix, "serverless-sql-warehouse-aes2-small")}"
      cluster_size              = try(unit_def.sql_warehouse.cluster_size, "Small")
      max_num_clusters          = try(unit_def.sql_warehouse.max_num_clusters, 2)
      min_num_clusters          = try(unit_def.sql_warehouse.min_num_clusters, 1)
      auto_stop_mins            = try(unit_def.sql_warehouse.auto_stop_mins, 10)
      enable_serverless_compute = try(unit_def.sql_warehouse.enable_serverless_compute, true)
      tags                      = try(unit_def.sql_warehouse.tags, {})
      warehouse_type            = try(unit_def.sql_warehouse.warehouse_type, "PRO")

      enable_permissions         = try(unit_def.sql_warehouse.enable_permissions, false)
      permissions                = try(unit_def.sql_warehouse.permissions, {})
    }
    if try(unit_def.sql_warehouse.enabled, false)
  }
}