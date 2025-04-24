variable "catalog_definitions" {
  type = map(object({
    schema_names  = list(string)
    catalog_access = map(list(string))  # Correct type for catalog_access
    #schema_access = map(map(list(string)))  # Correct type for schema_access
  }))
}
