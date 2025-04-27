terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
      configuration_aliases = [databricks.account]
    }
  }
}

resource "databricks_permission_assignment" "permission_assignment" {
  for_each    = var.permission_assignments
  #provider    = databricks.workspace
  principal_id = data.databricks_group.groups[each.key].id  # Use the group dynamically
  permissions  = each.value.permissions
}

resource "databricks_entitlement" "entitlement" {
  for_each          = var.entitlements
  #provider          = databricks.workspace
  group_id          = data.databricks_group.groups[each.key].id  # Use the group dynamically
  workspace_access  = each.value.workspace_access
  databricks_sql_access = each.value.databricks_sql_access
  depends_on        = [databricks_permission_assignment.permission_assignment]
}
