resource "azurerm_resource_group" "sasoleuw-simegas-dev-rg" {
  name     = "sasoleuw-simegas-dev-rg"
  location = "southafricanorth"
}

resource "azurerm_resource_group" "sasoleuw-simegas-dev-rg" {
  name     = "sasoleuw-simegas-dev-rg"
  location = "southafricanorth"
}

resource "azurerm_storage_account" "sasolzanwaescatalog" {
  name                      = "sasolzanwaescatalog"
  resource_group_name       = "sasoleuw-simegas-dev-rg"
  location                  = azurerm_resource_group.sasoleuw-simegas-dev-rg.location
  account_tier              = "Standard"
  account_replication_type  = "ZRS"
  is_hns_enabled            = true
}

resource "azurerm_storage_container" "metastore" {
  name                  = "metastore"
  storage_account_name  = azurerm_storage_account.sasolzanwaescatalog.name
  container_access_type = "private"
}

resource "databricks_metastore" "metastore" {
  provider      = databricks.azure_account
  name          = "metastore"
  storage_root  = "abfss://metastore@sasolzanwaescatalog.dfs.core.windows.net/managed-tables/88ad67c1-2d9f-448a-a740-155002742426"
  #owner         = "MetastoreAdmins"
  region        = "southafricanorth"
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
  workspace_id  = "3212216276919665"
}

resource "azurerm_user_assigned_identity" "sasolzan-simegas-catalog-id" {
  name                = "sasolzan-simegas-catalog-id"
  location            = azurerm_resource_group.sasoleuw-simegas-dev-rg.location
  resource_group_name = azurerm_resource_group.sasoleuw-simegas-dev-rg.name
}

resource "azurerm_databricks_access_connector" "sasolzan-simegas-catalog-conncetor" {
  name                = "sasolzan-simegas-catalog-conncetor"
  resource_group_name = azurerm_resource_group.sasoleuw-simegas-dev-rg.name
  location            = azurerm_resource_group.sasoleuw-simegas-dev-rg.location
  identity {
    type              = "UserAssigned"
    identity_ids      = [azurerm_user_assigned_identity.sasolzan-simegas-catalog-id.id]
  }
}