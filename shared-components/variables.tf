variable "storage_root" {
  description = "Location of the metastore root"
  type        = string
  default     = "abfss://metastore@mydatastorage.dfs.core.windows.net/"
}
