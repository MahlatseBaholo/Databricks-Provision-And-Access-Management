terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
  }
}

resource "databricks_cluster" "this" {
  cluster_name            = var.cluster_name
  spark_version           = var.spark_version
  node_type_id            = var.node_type_id
  driver_node_type_id     = var.driver_node_type_id
  autotermination_minutes = var.autotermination_minutes
  enable_elastic_disk     = var.enable_elastic_disk
  policy_id               = var.policy_id
  enable_local_disk_encryption = var.enable_local_disk_encryption
  data_security_mode      = var.data_security_mode
  runtime_engine          = var.runtime_engine
  apply_policy_default_values = var.apply_policy_default_values

  azure_attributes {
    first_on_demand     = var.azure_attributes.first_on_demand
    availability        = var.azure_attributes.availability
    spot_bid_max_price  = var.azure_attributes.spot_bid_max_price
  }

  autoscale {
    min_workers = var.autoscale.min_workers
    max_workers = var.autoscale.max_workers
  }
}

resource "databricks_permissions" "this" {
  cluster_id = databricks_cluster.this.id

  dynamic "access_control" {
    for_each = var.cluster_permissions
    content {
      principal   = access_control.key
      permissions = access_control.value
    }
  }
}