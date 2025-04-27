variable "groups" {
  description = "List of Databricks groups"
  type = map(string)
}

variable "users" {
  description = "List of Databricks users"
  type = map(string)
}

variable "groups_members" {
  description = "Mapping of group members"
  type = map(map(string))
}

variable "catalog_permissions" {
  description = "Catalog-level permissions"
  type = map(list(object({
    principal  = string
    permission = string
  })))
}

variable "schema_permissions" {
  description = "Schema-level permissions"
  type = map(list(object({
    catalog_name = string
    principal    = string
    permission   = string
  })))
}
