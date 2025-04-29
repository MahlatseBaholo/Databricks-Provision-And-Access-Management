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
  sql_warehouse_id = databricks_sql_endpoint.this.id

  dynamic "access_control" {
    for_each = flatten([
      for principal, perms in var.sql_warehouse_permissions : [
        for perm in perms : {
          principal  = principal
          permission = perm
        }
      ]
    ])
    content {
      group_name       = access_control.value.principal
      permission_level = access_control.value.permission
    }
  }
}
