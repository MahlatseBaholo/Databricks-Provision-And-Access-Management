variable "location" {
  description = "Azure location for the resource group"
  type        = string
  default     = "westeurope"
}

variable "databricks_storage_credential_name" {
  description = "Name of the Databricks storage credential"
  type        = string
}

