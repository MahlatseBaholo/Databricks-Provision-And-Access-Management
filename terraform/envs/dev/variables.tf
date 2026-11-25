variable "env" {
  description = "Deployment environment, e.g. dev, qa, prod"
  type        = string
}

variable "location_abbr" {
  description = "The Azure region short name (e.g., san, euw, eus, usw2)"
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
  type      = string
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
  default     = []
}

variable "permission_assignments" {
  description = "Mapping of principal_id to permissions"
  type = map(object({
    principal_id = string
    permissions  = list(string)
  }))
  default = {}
}

variable "entitlements" {
  description = "Mapping of group_id to workspace entitlements"
  type = map(object({
    group_id              = string
    workspace_access      = bool
    databricks_sql_access = bool
  }))
  default = {}
}

variable "cluster_name" {
  description = "Name of the Databricks cluster (legacy). Prefer unit_definitions."
  type        = string
  default     = null
}

variable "spark_version" {
  description = "Spark version to use (legacy). Prefer unit_definitions."
  type        = string
  default     = null
}

variable "node_type_id" {
  description = "Node type for worker nodes (legacy). Prefer unit_definitions."
  type        = string
  default     = null
}

variable "driver_node_type_id" {
  description = "Node type for the driver node (legacy). Prefer unit_definitions."
  type        = string
  default     = null
}

variable "autotermination_minutes" {
  description = "Minutes until auto-termination (global default / legacy)"
  type        = number
  default     = 10
}

variable "data_security_mode" {
  description = "Unity Catalog enablement (legacy). Prefer unit_definitions."
  type        = string
  default     = null
}

variable "azure_attributes" {
  description = "Azure attributes block (legacy). Prefer unit_definitions."
  type        = map(any)
  default     = {}
}

variable "autoscale" {
  description = "Autoscale settings (optional global default / legacy)"
  type = object({
    min_workers = number
    max_workers = number
  })
  default = null
}

variable "cluster_permissions" {
  description = "Permissions for the cluster (legacy). Prefer unit_definitions."
  type        = map(list(string))
  default     = {}
}

variable "sql_warehouse_name" {
  description = "Name of the SQL Warehouse (legacy). Prefer unit_definitions."
  type        = string
  default     = null
}

variable "sql_warehouse_cluster_size" {
  description = "Cluster size (e.g. Small, Medium) (legacy). Prefer unit_definitions."
  type        = string
  default     = null
}

variable "sql_warehouse_max_num_clusters" {
  type    = number
  default = 1
}

variable "sql_warehouse_min_num_clusters" {
  type    = number
  default = 1
}

variable "sql_warehouse_auto_stop_mins" {
  type    = number
  default = 10
}

variable "sql_warehouse_enable_serverless_compute" {
  type    = bool
  default = true
}

variable "sql_warehouse_tags" {
  type    = map(string)
  default = {}
}

variable "warehouse_type" {
  description = "SQL warehouse type (legacy). Prefer unit_definitions."
  type        = string
  default     = null
}

variable "sql_warehouse_enable_permissions" {
  type    = bool
  default = false
}

variable "sql_warehouse_permissions" {
  type    = map(list(string))
  default = {}
}

variable "catalog_definitions" {
  type = map(object({
    project        = string
    schema_names   = list(string)
    catalog_access = map(list(string))
    schema_access  = map(map(list(string)))
    comment        = optional(string)

    # Optional existing-storage configuration
    storage_account_name   = optional(string)
    storage_container_name = optional(string)
    storage_folder         = optional(string)

    schema_paths = optional(map(string), {})
  }))

  validation {
    condition = alltrue([
      for _, definition in var.catalog_definitions :
      (
        definition.storage_account_name == null &&
        definition.storage_container_name == null
      ) || (
        definition.storage_account_name != null &&
        definition.storage_container_name != null
      )
    ])

    error_message = "storage_account_name and storage_container_name must either both be provided or both be omitted."
  }

  validation {
    condition = alltrue([
      for _, definition in var.catalog_definitions :
      definition.storage_folder == null ||
      (
        definition.storage_account_name != null &&
        definition.storage_container_name != null
      )
    ])

    error_message = "storage_folder can only be provided when storage_account_name and storage_container_name are also provided."
  }

  validation {
    condition = alltrue([
      for _, definition in var.catalog_definitions :
      length(
        setsubtract(
          toset(keys(definition.schema_paths)),
          toset(definition.schema_names)
        )
      ) == 0
    ])

    error_message = "schema_paths can only contain schemas defined in schema_names."
  }
}

variable "folder_path" {
  type        = string
  description = "Path of the folder (legacy, single). Prefer folder_permissions."
  default     = null
}

variable "folder_paths" {
  type        = list(string)
  description = "Folders that use the shared access_controls"
  default     = []

  validation {
    condition     = alltrue([for p in var.folder_paths : startswith(p, "/Workspace/")])
    error_message = "Each folder path must be a full path starting with /Workspace/."
  }
}

variable "access_controls" {
  type = list(object({
    group_name       = string
    permission_level = string
  }))
  description = "Shared permissions applied to folder_path / folder_paths"
  default     = []

  validation {
    condition     = length(var.access_controls) == length(distinct([for a in var.access_controls : a.group_name]))
    error_message = "A group can only appear once in access_controls (use the highest level needed)."
  }

  validation {
    condition = alltrue([
      for a in var.access_controls :
      contains(["CAN_READ", "CAN_RUN", "CAN_EDIT", "CAN_MANAGE"], a.permission_level)
    ])
    error_message = "permission_level must be one of CAN_READ, CAN_RUN, CAN_EDIT, CAN_MANAGE."
  }
}

variable "folder_permissions" {
  description = "Per-folder permissions. Overrides access_controls for the folders listed."
  type = map(list(object({
    group_name       = string
    permission_level = string
  })))
  default = {}

  validation {
    condition     = alltrue([for p in keys(var.folder_permissions) : startswith(p, "/Workspace/")])
    error_message = "Each folder path must be a full path starting with /Workspace/."
  }

  validation {
    condition = alltrue([
      for p, acl in var.folder_permissions :
      length(acl) == length(distinct([for a in acl : a.group_name]))
    ])
    error_message = "A group can only appear once per folder (use the highest level needed)."
  }

  validation {
    condition = alltrue(flatten([
      for p, acl in var.folder_permissions : [
        for a in acl :
        contains(["CAN_READ", "CAN_RUN", "CAN_EDIT", "CAN_MANAGE"], a.permission_level)
      ]
    ]))
    error_message = "permission_level must be one of CAN_READ, CAN_RUN, CAN_EDIT, CAN_MANAGE."
  }
}

variable "allowed_units" {
  description = "Authoritative list of allowed units"
  type        = set(string)
  default     = ["aes_pm","risk_she","dpms"]
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

      size    = optional(string, "small")
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
      name_suffix               = optional(string, "serverless-sql-warehouse-aes3-small")
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

  validation {
    condition     = length(setsubtract(toset(keys(var.unit_definitions)), var.allowed_units)) == 0
    error_message = "One or more unit_definitions keys are not allowed. Check allowed_units."
  }
}