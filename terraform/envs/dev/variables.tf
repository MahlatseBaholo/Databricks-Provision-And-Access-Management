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
    group_id             = string
    workspace_access     = bool
    databricks_sql_access = bool
  }))
}

variable "catalog_definitions" {
  type = map(object({
    project        = string
    schema_names   = list(string)
    catalog_access = map(list(string))
    schema_access  = map(map(list(string)))
  }))
}