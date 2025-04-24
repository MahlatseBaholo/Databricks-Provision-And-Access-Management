variable "catalog_definitions" {
  description = "Catalog definitions with schema access mappings"
  type = map(object({
    schema_names   = list(string)
    catalog_access = map(list(string))
    schema_access  = map(map(list(string)))
  }))
}
