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

variable "enable_elastic_disk" {
  description = "Whether to enable elastic disk"
  type        = bool
}

variable "policy_id" {
  description = "Cluster policy ID"
  type        = string
}

variable "enable_local_disk_encryption" {
  description = "Enable local disk encryption"
  type        = bool
}

variable "data_security_mode" {
  description = "Data security mode"
  type        = string
}

variable "runtime_engine" {
  description = "Runtime engine"
  type        = string
}

variable "apply_policy_default_values" {
  description = "Apply policy default values"
  type        = bool
}

variable "azure_attributes" {
  description = "Azure attributes block"
  type        = map(any)
}

variable "autoscale" {
  description = "Autoscale settings"
  type        = map(any)
}

variable "cluster_permissions" {
  description = "Permissions for the cluster"
  type = map(string) # not map(list(string))
}

variable "catalog_definitions" {
  type = map(object({
    project        = string
    schema_names   = list(string)
    catalog_access = map(list(string))
    schema_access  = map(map(list(string)))
  }))
}