variable "catalog_definitions" {
  description = "Catalog definitions with schema access and access grants"
  type = map(object({
    schema_names   = list(string)
    catalog_access = map(list(string))
    schema_access  = map(map(list(string)))
  }))
}
