variable "resource_group_name_storage_account" {
  description = "The name of the resource group for the workspace"
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