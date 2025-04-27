variable "cluster_name" { type = string }
variable "spark_version" { type = string }
variable "node_type_id" { type = string }
variable "driver_node_type_id" { type = string }
variable "autotermination_minutes" { type = number }
variable "enable_elastic_disk" { type = bool }
variable "policy_id" { type = string }
variable "enable_local_disk_encryption" { type = bool }
variable "data_security_mode" { type = string }
variable "runtime_engine" { type = string }
variable "apply_policy_default_values" { type = bool }

variable "azure_attributes" {
  type = object({
    first_on_demand    = number
    availability       = string
    spot_bid_max_price = number
  })
}

variable "autoscale" {
  type = object({
    min_workers = number
    max_workers = number
  })
}

variable "cluster_permissions" {
  description = "Map of principal => list of permissions to assign to the cluster"
  type = map(list(string))
}
