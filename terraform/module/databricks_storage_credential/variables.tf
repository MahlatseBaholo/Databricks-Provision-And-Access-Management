variable "name" {
  description = "Name of the Databricks storage credential"
  type        = string
}

variable "access_connector_id" {
  description = "Azure Databricks Access Connector ID"
  type        = string
}

variable "managed_identity_id" {
  description = "User Assigned Managed Identity ID"
  type        = string
}
