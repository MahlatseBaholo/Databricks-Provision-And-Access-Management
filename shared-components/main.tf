resource "databricks_metastore" "metastore" {
  provider      = databricks.azure_account
  name          = "metastore"
  storage_root  = "abfss://metastore@sasoleuwaescatalog.dfs.core.windows.net/managed-tables/88ad67c1-2d9f-448a-a740-155002742426"
  owner         = "MetastoreAdmins"
  region        = "westeurope"
#  sku           = "premium"
}

resource "azurerm_databricks_workspace" "workspace" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name_workspace
  sku                 = "premium"
}

resource "databricks_metastore_assignment" "metastore" {
  provider      = databricks.azure_account
  metastore_id  = databricks_metastore.metastore.id
  workspace_id  = "3787911233650262"
}