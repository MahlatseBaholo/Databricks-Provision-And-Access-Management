variable "databricks_storage_credential_name" {
  description = "Name of the Databricks storage credential"
  type        = string
}

variable "databricks_databricks_external_location" {
  description = "The name for the external location"
  type        = string
}

variable "storage_container" {
  description = "The name of the ADLS storage container"
  type        = string
}
