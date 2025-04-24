variable "catalog_name" {
  type = string
}

variable "schema_access" {
  type = map(map(list(string)))
}