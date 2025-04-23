resource "databricks_metastore" "this" {
  name         = "metastore"
  storage_root = "abfss://shared-components@sasolterraform.dfs.core.windows.net/"
  region       = "westeurope"
}
