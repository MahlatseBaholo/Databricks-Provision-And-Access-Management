variable "region" {
  description = "The region where resources will be created"
  type        = string
  default     = "westeurope"  # Default value for region
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}
