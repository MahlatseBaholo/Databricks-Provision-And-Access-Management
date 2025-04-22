variable "region" {
  description = "The region where resources will be created"
  type        = string
  default     = "us-west-2"  # Default value for region
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}
