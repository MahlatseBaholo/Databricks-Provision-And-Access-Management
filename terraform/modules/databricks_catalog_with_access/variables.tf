variable "catalog_name" {
  type = string
}

variable "storage_root" {
  type = string
}

variable "schema_names" {
  type = list(string)
}

variable "catalog_access" {
  type = map(list(string))
}

variable "schema_access" {
  type = map(map(list(string)))
  default     = {}
}

variable "schema_paths" {
  description = "Optional storage path for each schema relative to the catalog storage root"
  type        = map(string)
  default     = {}
}
