variable "resource_group_name_workspace" {
  description = "Name of the Resource Group for the Databricks Workspace"
  type        = string
}

variable "location" {
  description = "Azure location for the resource group"
  type        = string
  default     = "westeurope"
}

variable "databricks_workspace_name" {
  type        = string
  description = "Databricks workspace name"
}
