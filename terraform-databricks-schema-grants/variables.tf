variable "catalog_definitions" {
  description = "Catalog definitions with schema and access information"
  type = map(object({
    schema_names   = list(string)
    catalog_access = map(list(string))
    schema_access  = map(map(list(string)))
  }))
}

variable "schema_access" {
  description = "Access grants at schema level."
  type        = map(map(list(string)))
  default     = {}
}
