#variable "storage_root" {
#  description = "Location of the metastore root"
#  type        = string
#  default     = "abfss://shared-components@sasoldevsimegasterraform.dfs.core.windows.net/"
#}

variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
  sensitive = true
}

variable "account_id" {
  type      = string
  sensitive = true
}

#variable "account_client_id" {
#  type      = string
#  sensitive = true
#}

#variable "account_client_secret" {
#  type      = string
#  sensitive = true
#}

variable "workspace_host" {
  type = string
}

variable "workspace_client_id" {
  type      = string
  sensitive = true
}

variable "workspace_client_secret" {
  type      = string
  sensitive = true
}