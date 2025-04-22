resource "azurerm_resource_group" "sasoleuw-big-data-dev-aes-rg" {
  name     = "sasoleuw-big-data-dev-aes-rg"
  location = "westeurope"
}

resource "azurerm_resource_group" "sasoleuw-big-data-aes-unity-catalog-rg" {
  name     = "sasoleuw-big-data-aes-unity-catalog-rg"
  location = "westeurope"
}

resource "databricks_group" "MetastoreAdmins" {
  provider     = databricks.azure_account
  display_name = "MetastoreAdmins"
}

resource "databricks_metastore" "metastore" {
  provider      = databricks.azure_account
  name          = "metastore"
  storage_root  = "abfss://metastore@sasoleuwaescatalog.dfs.core.windows.net/managed-tables/88ad67c1-2d9f-448a-a740-155002742426"
  owner         = "MetastoreAdmins"
  region        = "westeurope"
#  sku           = "premium"
}

resource "databricks_metastore_assignment" "metastore" {
  provider      = databricks.azure_account
  metastore_id  = databricks_metastore.metastore.id
  workspace_id  = "1627607411856178"
}

resource "azurerm_databricks_workspace" "sasol-dev-aes-dbw" {
  provider            = azurerm
  name                = "sasol-dev-aes-dbw"
  resource_group_name = "sasoleuw-big-data-dev-aes-rg"
  location            = "westeurope"
  sku                 = "premium"
}

resource "azurerm_storage_account" "sasoleuwaescatalog" {
  name                      = "sasoleuwaescatalog"
  resource_group_name       = "sasoleuw-big-data-aes-unity-catalog-rg"
  location                  = azurerm_resource_group.sasoleuw-big-data-aes-unity-catalog-rg.location
  account_tier              = "Standard"
  account_replication_type  = "ZRS"
  is_hns_enabled            = true
}

resource "azurerm_storage_container" "metastore" {
  name                  = "metastore"
  storage_account_name  = azurerm_storage_account.sasoleuwaescatalog.name
  container_access_type = "private"
}


provider "databricks" {
  host                        = "https://<your-databricks-instance>"
  azure_workspace_resource_id = "<your-workspace-resource-id>"
}

locals {
  metastore_id   = "88ad67c1-2d9f-448a-a740-155002742426"
  access_config  = yamldecode(file("${path.module}/access.yaml"))
}

module "metastore_assignment" {
  source  = "data-platform-hq/metastore-assignment/databricks"
  version = "~> 1.0.0"

  workspace_id = "<your-workspace-id>"
  metastore_id = local.metastore_id

  providers = {
    databricks = databricks
  }
}

module "unity_catalog" {
  source  = "data-platform-hq/unity-catalog/databricks"
  version = "~> 1.1.0"

  env              = "development"
  metastore_id     = local.metastore_id
  #metastore_grants = [
  #  {
  #    principal  = "admin@databricks.com"
  #    privileges = ["CREATE_CATALOG", "CREATE_EXTERNAL_LOCATION"]
  #  },
  #  {
  #    principal  = "governance@databricks.com"
  #    privileges = ["CREATE_SHARE", "CREATE_RECIPIENT", "CREATE_PROVIDER"]
  #  }
  #]

  catalog = local.access_config

  depends_on = [module.metastore_assignment]

  providers = {
    databricks = databricks
  }
}