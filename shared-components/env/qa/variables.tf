variable "workspace_ids" {
  description = "List of workspace IDs to assign the metastore to"
  type        = list(string)
  default     = ["1803701311157133", "workspace_id_2", "workspace_id_3"]
}

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

variable "account_client_id" {
  type      = string
  sensitive = true
}

variable "account_client_secret" {
  type      = string
  sensitive = true
}

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

