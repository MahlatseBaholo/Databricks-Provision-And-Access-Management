terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
      configuration_aliases = [databricks]
    }
  }
}

resource "databricks_directory" "this" {
  path = var.directory_path
}

resource "databricks_permissions" "folder_usage" {
  directory_path = databricks_directory.this.path
  depends_on     = [databricks_directory.this]

  dynamic "access_control" {
    for_each = var.access_controls
    content {
      group_name       = access_control.key
      permission_level = access_control.value.permission_level
    }
  }
}

