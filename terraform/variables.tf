variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "resource_group_location" {
  description = "Azure location for the resource group"
  type        = string
  default     = "westeurope"
}
