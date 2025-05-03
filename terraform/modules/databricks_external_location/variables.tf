variable "name" {
  type = string
}

variable "url" {
  description = "The abfss URL of the external location"
  type        = string
}

variable "credential_name" {
  description = "Databricks credential to access the external location"
  type        = string
}

#variable "read_group" {
#  description = "Optional group name to grant read access"
 # type        = string
 # default     = null
#}
