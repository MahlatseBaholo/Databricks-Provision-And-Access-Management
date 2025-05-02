terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
      configuration_aliases = [databricks.account,databricks.workspace]
    }
  }
}

data "databricks_group" "groups" {
  for_each    = toset(var.group_names)
  provider    = databricks.account
  display_name = each.value
}

resource "databricks_permission_assignment" "permission_assignment" {
  for_each    = var.permission_assignments
  provider    = databricks.workspace
  principal_id = data.databricks_group.groups[each.key].id
  permissions  = each.value.permissions
}

resource "databricks_entitlements" "entitlements" {
  for_each          = var.entitlements
  provider          = databricks.workspace
  group_id          = data.databricks_group.groups[each.key].id
  workspace_access  = each.value.workspace_access
  databricks_sql_access = each.value.databricks_sql_access
  depends_on        = [databricks_permission_assignment.permission_assignment]
}
