variable "name" {
  description = "Name of the SQL warehouse"
  type        = string
}

variable "cluster_size" {
  description = "Cluster size (e.g., 2X-Small, Small, Medium)"
  type        = string
}

variable "max_num_clusters" {
  description = "Maximum number of clusters"
  type        = number
  default     = 1
}

variable "min_num_clusters" {
  description = "Minimum number of clusters"
  type        = number
  default     = 1
}

variable "auto_stop_mins" {
  description = "Auto stop time in minutes"
  type        = number
  default     = 10
}

variable "enable_serverless_compute" {
  description = "Enable serverless compute"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags for the warehouse"
  type        = map(string)
  default     = {}
}

variable "warehouse_type" {
  type        = string
  description = "SQL warehouse type"
}

variable "enable_permissions" {
  description = "Whether to assign permissions"
  type        = bool
  default     = false
}

variable "permissions" {
  description = "Permissions map: { group_name = [permissions] }"
  type        = map(list(string))
  default     = {}
}
