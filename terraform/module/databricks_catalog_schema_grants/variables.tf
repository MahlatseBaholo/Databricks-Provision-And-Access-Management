variable "catalog_name" {
  description = "The name of the catalog."
  type        = string
}

variable "schema_names" {
  description = "List of schema names."
  type        = list(string)
}

variable "schema_access" {
  description = "Access grants at schema level."
  type = map(map(list(string)))
}
