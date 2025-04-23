variable "name" {
  type = string
}

variable "credential_name" {
  description = "The name or ID of the storage credential"
  type        = string
}

variable "url" {
  description = "The URL for the external location"
  type        = string
}
