variable "directory_path" {
  description = "Path to create the folder under /Workspace"
  type        = string
}

variable "access_controls" {
  description = "List of access control entries"
  type = list(object({
    group_name       = string
    permission_level = string
  }))
}
