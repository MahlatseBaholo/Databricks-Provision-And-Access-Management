terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
      configuration_aliases = [databricks] 
    }
  }
}

resource "databricks_permission_assignment" "permission_assignment" {
  for_each = var.permission_assignments 
  provider     = databricks.workspace
  principal_id = each.value.principal_id
  permissions  = each.value.permissions
}

resource "databricks_entitlement" "entitlement" {
  for_each = var.entitlements
  provider               = databricks.workspace
  group_id               = each.value.group_id
  workspace_access       = each.value.workspace_access
  databricks_sql_access  = each.value.databricks_sql_access
  depends_on             = [databricks_permission_assignment.permission_assignment]
}
