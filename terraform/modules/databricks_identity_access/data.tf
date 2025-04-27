data "databricks_group" "groups" {
  for_each    = toset(var.group_names)
  provider    = databricks.account
  display_name = each.value
}