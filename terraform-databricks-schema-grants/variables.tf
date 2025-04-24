variable "catalog_definitions" {
  type = map(object({
    schema_names    = list(string)
    catalog_access  = map(list(string))
    schema_access   = map(map(list(string)))
  }))
}