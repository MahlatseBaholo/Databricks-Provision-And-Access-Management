resource "databricks_metastore_assignment" "metastore" {
  metastore_id = var.metastore_id
  workspace_id = var.workspace_id
  #default_catalog_name = "main"
}
