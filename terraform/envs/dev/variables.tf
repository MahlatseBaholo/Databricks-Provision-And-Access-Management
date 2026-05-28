variable "env" {
  description = "Deployment environment, e.g. dev, qa, prod"
  type        = string
}

variable "location_abbr" {
  description = "The Azure region short name (e.g.,san, euw, eus, usw2)"
  type        = string
  default     = "euw" 
}

variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
  sensitive = true
}

variable "account_id" {
  type      = string
  sensitive = true
}

variable "account_client_id" {
  type      = string
  sensitive = true
}

variable "account_client_secret" {
  type      = string
  sensitive = true
}

variable "workspace_host" {
  type = string
}

variable "workspace_client_id" {
  type      = string
  sensitive = true
}

variable "workspace_client_secret" {
  type      = string
  sensitive = true
}

variable "group_names" {
  description = "List of Databricks group names"
  type        = list(string)
}

variable "permission_assignments" {
  description = "Mapping of principal_id to permissions"
  type = map(object({
    principal_id = string
    permissions  = list(string)
  }))
}

variable "entitlements" {
  description = "Mapping of group_id to workspace entitlements"
  type = map(object({
    group_id              = string
    workspace_access      = bool
    databricks_sql_access = bool
  }))
}

variable "cluster_name" {
  description = "Name of the Databricks cluster"
  type        = string
}

variable "spark_version" {
  description = "Spark version to use"
  type        = string
}

variable "node_type_id" {
  description = "Node type for worker nodes"
  type        = string
}

variable "driver_node_type_id" {
  description = "Node type for the driver node"
  type        = string
}

variable "autotermination_minutes" {
  description = "Minutes until auto-termination"
  type        = number
}

variable "data_security_mode" {
  description = "Unity Catalog enablement"
  type        = string
}

variable "azure_attributes" {
  description = "Azure attributes block"
  type        = map(any)
}

variable "autoscale" {
  description = "Autoscale settings (optional global default)"
  type = object({
    min_workers = number
    max_workers = number
  })
  default = null
}

variable "cluster_permissions" {
  description = "Permissions for the cluster"
  type        = map(list(string))
}

variable "sql_warehouse_name" {
  type        = string
  description = "Name of the SQL Warehouse"
}

variable "sql_warehouse_cluster_size" {
  type        = string
  description = "Cluster size (e.g. Small, Medium)"
}

variable "sql_warehouse_max_num_clusters" {
  type        = number
  default     = 1
}

variable "sql_warehouse_min_num_clusters" {
  type        = number
  default     = 1
}

variable "sql_warehouse_auto_stop_mins" {
  type        = number
  default     = 10
}

variable "sql_warehouse_enable_serverless_compute" {
  type        = bool
  default     = true
}

variable "sql_warehouse_tags" {
  type        = map(string)
  default     = {}
}

variable "warehouse_type" {
  type        = string
  description = "SQL warehouse type"
}

variable "sql_warehouse_enable_permissions" {
  type        = bool
  default     = false
}

variable "sql_warehouse_permissions" {
  type        = map(list(string))
  default     = {}
}

variable "catalog_definitions" {
  type = map(object({
    project        = string
    schema_names   = list(string)
    catalog_access = map(list(string))
    schema_access  = map(map(list(string)))
  }))
}

variable "folder_path" {
  type        = string
  description = "Path of the folder"
}

variable "access_controls" {
  type = list(object({
    group_name       = string
    permission_level = string
  }))
  description = "List of permissions to assign to the folder"
}

variable "allowed_units" {
  description = "Authoritative list of allowed units"
  type        = set(string)
  default     = ["ms", "finance"]
}

variable "units" {
  description = "Units to provision resources for (legacy). Prefer unit_definitions."
  type        = set(string)
  default     = []
}

variable "unit_definitions" {
  description = "Per-unit cluster and optional SQL warehouse config"
  type = map(object({
    cluster = object({
      spark_version           = string
      node_type_id            = string
      driver_node_type_id     = optional(string)
      autotermination_minutes = optional(number)
      data_security_mode      = optional(string)

      size    = optional(string, "small")            # for naming only
      purpose = optional(string, "general-purpose")  

      azure_attributes = optional(object({
        first_on_demand    = optional(number)
        availability       = optional(string)
        spot_bid_max_price = optional(number)
      }))

      autoscale = optional(object({
        min_workers = number
        max_workers = number
      }))

      cluster_permissions = optional(map(list(string)), {})
    })

    sql_warehouse = optional(object({
      enabled                   = optional(bool, false)
      name_suffix               = optional(string, "serverless-sql-warehouse-aes2-small")
      cluster_size              = optional(string, "Small")
      max_num_clusters          = optional(number, 2)
      min_num_clusters          = optional(number, 1)
      auto_stop_mins            = optional(number, 10)
      enable_serverless_compute = optional(bool, true)
      tags                      = optional(map(string), {})
      warehouse_type            = optional(string, "PRO")
      enable_permissions        = optional(bool, false)
      permissions               = optional(map(list(string)), {})
    }))
  }))
}
