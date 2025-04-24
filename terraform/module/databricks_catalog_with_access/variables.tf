variable "catalog_definitions" {
  description = "Map of catalog definitions including storage_root, schemas, and access"
  type = map(object({
    storage_root   = string
    schema_names   = list(string)
    catalog_access = map(list(string))
    schema_access  = map(map(list(string)))
  }))
}
