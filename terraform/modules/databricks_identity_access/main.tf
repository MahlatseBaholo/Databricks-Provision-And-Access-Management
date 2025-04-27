resource "databricks_group" "group" {
  for_each = var.groups
  display_name = each.key
}

resource "databricks_group_member" "group_member" {
  for_each = var.groups_members
  group_id  = databricks_group.group[each.key].id
}