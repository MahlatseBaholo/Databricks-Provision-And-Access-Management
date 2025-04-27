variable "cluster_name" {
  type = string
}

variable "spark_version" {
  type = string
}

variable "node_type_id" {
  type = string
}

variable "driver_node_type_id" {
  type = string
}

variable "autotermination_minutes" {
  type = number
}

variable "enable_elastic_disk" {
  type = bool
}

variable "policy_id" {
  type = string
}

variable "enable_local_disk_encryption" {
  type = bool
}

variable "data_security_mode" {
  type = string
}

variable "runtime_engine" {
  type = string
}

variable "apply_policy_default_values" {
  type = bool
}

variable "azure_attributes" {
  type = map(any) 
}

variable "autoscale" {
  type = map(any)
}

variable "cluster_permissions" {
  type = map(list(string))
}
