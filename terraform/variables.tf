variable "storage_definitions" {
  type = map(object({
    container_name                     = string
    storage_credential_name            = string
    external_location_name             = string
  }))
}
