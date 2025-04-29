terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
      configuration_aliases = [databricks]
    }
  }
}

resource "databricks_sql_endpoint" "this" {
  name                     = var.name
  cluster_size             = var.cluster_size
  max_num_clusters         = var.max_num_clusters
  min_num_clusters         = var.min_num_clusters
  auto_stop_mins           = var.auto_stop_mins
  enable_serverless_compute = var.enable_serverless_compute
}

resource "databricks_permissions" "this" {
  count      = var.enable_permissions ? 1 : 0
  sql_endpoint_id = databricks_sql_endpoint.this.id

  access_control {
    for_each    = var.permissions
    principal   = access_control.key
    permissions = access_control.value
  }
}
