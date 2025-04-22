variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "westeurope"
}

variable "project_name" {
  description = "Name of the project or workload"
  type        = string
}

variable "resource_group_name_workspace" {
  description = "Resource group name for Databricks workspace"
  type        = string
}

variable "resource_group_name_catalog" {
  description = "Resource group name for Unity Catalog related resources"
  type        = string
}

variable "databricks_workspace_name" {
  description = "Name of the Databricks workspace"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account for Unity Catalog"
  type        = string
}

variable "container_name" {
  description = "Name of the container for metastore"
  type        = string
  default     = "metastore"
}

variable "user_assigned_identity_name" {
  description = "Name of the user-assigned identity for storage access"
  type        = string
}

variable "databricks_access_connector_name" {
  description = "Name of the Databricks access connector"
  type        = string
}

variable "external_location_name" {
  description = "Name of the Databricks external location"
  type        = string
}

variable "storage_credential_name" {
  description = "Name of the Databricks storage credential"
  type        = string
}

variable "metastore_id" {
  description = "ID of the existing Unity Catalog metastore"
  type        = string
}

variable "workspace_id" {
  description = "ID of the Databricks workspace to assign metastore"
  type        = string
}

variable "unity_catalog" {
  description = "Path to the access.yaml file for catalog/schema permissions"
  type        = string
  default     = "${path.module}/access.yaml"
}
