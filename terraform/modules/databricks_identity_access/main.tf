terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
      configuration_aliases = [databricks] 
    }
  }
}

resource "databricks_permission_assignment" "permission_assignment" {
  for_each = toset(var.group_names)
  provider     = databricks.workspace
  principal_id = data.databricks_group.groups[each.value].id
  permissions  = ["USER"]  
}

resource "databricks_entitlement" "entitlement" {
  for_each = toset(var.group_names)
  provider               = databricks.workspace
  group_id               = data.databricks_group.groups[each.value].id
  workspace_access       = true
  databricks_sql_access  = true
  depends_on             = [databricks_permission_assignment.permission_assignment]
}