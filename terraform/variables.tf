variable "storage_definitions" {
  type = map(object({
    container_name                     = string
    storage_credential_name            = string
    external_location_name             = string
  }))
}

variable "catalog_definitions" {
  description = "Map of catalog definitions with schema names and access controls"
  type = map(object({
    storage_root    = string
    schema_names    = list(string)
    catalog_access  = map(list(string))
    schema_access   = map(map(list(string)))
  }))
}
