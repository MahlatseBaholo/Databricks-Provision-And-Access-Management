variable "catalog_name" {
  type = string
}

variable "storage_root" {
  type = string
}

variable "schema_names" {
  type = list(string)
}

variable "catalog_access" {
  type = map(list(string))
}

variable "schema_access" {
  type = map(map(list(string)))
}
