variable "resource_group_name_workspace" {
  description = "Name of the resource group"
  type        = string
}

variable "resource_group_name_catalog" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure location for the resource group"
  type        = string
  default     = "westeurope"
}
