variable "catalog_definitions" {
  type = map(object({
    schema_access   = map(map(list(string)))
  }))
}