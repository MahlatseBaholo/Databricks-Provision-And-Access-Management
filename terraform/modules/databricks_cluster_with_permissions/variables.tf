# modules/databricks_cluster_with_permissions/variables.tf

variable "cluster_name" {
  description = "Name of the Databricks cluster"
  type        = string
}

variable "spark_version" {
  description = "Spark version to use"
  type        = string
}

variable "node_type_id" {
  description = "Node type for worker nodes"
  type        = string
}

variable "driver_node_type_id" {
  description = "Node type for the driver node"
  type        = string
}

variable "autotermination_minutes" {
  description = "Minutes until auto-termination"
  type        = number
}

variable "azure_attributes" {
  description = "Azure attributes block"
  type        = map(any)
}

variable "autoscale" {
  description = "Autoscale settings"
  type        = map(any)
}

variable "cluster_permissions" {
  description = "Permissions for the cluster"
  type        = map(list(string))
}

