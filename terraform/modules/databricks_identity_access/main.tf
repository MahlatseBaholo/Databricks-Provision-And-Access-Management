terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
      configuration_aliases = [databricks.account] 
    }
  }
}

data "databricks_group" "groups" {
  for_each    = toset(var.group_names)
  provider    = databricks.account
  display_name = each.value  # Fetching group by display_name dynamically
}

resource "databricks_permission_assignment" "permission_assignment" {
  for_each = var.permission_assignments
  principal_id = data.databricks_group.groups[each.key].id
  permissions  = each.value.permissions
}

resource "databricks_entitlement" "entitlements" {
  for_each = var.entitlements
  group_id               = data.databricks_group.groups[each.key].id
  workspace_access       = each.value.workspace_access
  databricks_sql_access  = each.value.databricks_sql_access
  depends_on             = [databricks_permission_assignment.permission_assignment]
}
