variable "catalog_name" {
  type = string
}

variable "schema_names" {
  type = list(string)
}

variable "schema_access" {
  type = map(map(list(string)))
}
