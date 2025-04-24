variable "catalog_name" {
  type = string
}

variable "catalog_access" {
  type = map(list(string))
  default = {}
}

variable "schema_access" {
  type = map(map(list(string)))
  default = {}
}
