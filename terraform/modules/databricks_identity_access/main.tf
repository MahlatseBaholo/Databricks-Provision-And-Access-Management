resource "databricks_group" "group" {
  for_each = var.groups
  display_name = each.key
}

resource "databricks_user" "user" {
  for_each = var.users
  user_name  = each.key
}

resource "databricks_group_member" "group_member" {
  for_each = var.groups_members
  group_id  = databricks_group.group[each.key].id
  member_id = databricks_user.user[each.value].id
}

resource "databricks_permissions" "catalog_permissions" {
  for_each = var.catalog_permissions

  catalog_name = each.key
  access_control_list {
    principal = each.value.principal
    permission = each.value.permission
  }
}

resource "databricks_permissions" "schema_permissions" {
  for_each = var.schema_permissions

  schema_name  = each.key
  catalog_name = each.value.catalog_name
  access_control_list {
    principal = each.value.principal
    permission = each.value.permission
  }
}
