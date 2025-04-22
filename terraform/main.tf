resource "azurerm_resource_group" "sasoleuw-simegas-dev-rg" {
  name     = "sasoleuw-simegas-dev-rg"
  location = "westeurope"
}

resource "azurerm_resource_group" "sasoleuw-big-data-simegas-unity-catalog-rg" {
  name     = "sasoleuw-big-data-simegas-unity-catalog-rg"
  location = "westeurope"
}

resource "databricks_group" "MetastoreAdmins" {
  provider     = databricks.azure_account
  display_name = "MetastoreAdmins"
}

resource "databricks_metastore" "metastore" {
  provider      = databricks.azure_account
  name          = "metastore"
  storage_root  = "abfss://metastore@sasoleuwsimegascatalog.dfs.core.windows.net/managed-tables/88ad67c1-2d9f-448a-a740-155002742426"
  owner         = "MetastoreAdmins"
  region        = "westeurope"
#  sku           = "premium"
}

resource "databricks_metastore_assignment" "metastore" {
  provider      = databricks.azure_account
  metastore_id  = databricks_metastore.metastore.id
  workspace_id  = ""
}

resource "azurerm_databricks_workspace" "sasol-dev-simegas-dbw" {
  provider            = azurerm
  name                = "sasol-dev-simegas-dbw"
  resource_group_name = "sasoleuw-simegas-dev-rg"
  location            = "westeurope"
  sku                 = "premium"
}

resource "azurerm_storage_account" "sasoleuwsimegascatalog" {
  name                      = "sasoleuwsimegascatalog"
  resource_group_name       = "sasoleuw-big-data-simegas-unity-catalog-rg"
  location                  = azurerm_resource_group.sasoleuw-big-data-simegas-unity-catalog-rg.location
  account_tier              = "Standard"
  account_replication_type  = "ZRS"
  is_hns_enabled            = true
}

resource "azurerm_storage_container" "metastore" {
  name                  = "metastore"
  storage_account_name  = azurerm_storage_account.sasoleuwsimegascatalog.name
  container_access_type = "private"
}


resource "azurerm_user_assigned_identity" "sasoleuw-simegas-catalog-id" {
  name                = "sasoleuw-simegas-catalog-id"
  location            = azurerm_resource_group.sasoleuw-big-data-simegas-unity-catalog-rg.location
  resource_group_name = azurerm_resource_group.sasoleuw-big-data-simegas-unity-catalog-rg.name
}

resource "azurerm_databricks_access_connector" "sasoleuw-simegas-catalog-conncetor" {
  name                = "sasoleuw-simegas-catalog-conncetor"
  resource_group_name = azurerm_resource_group.sasoleuw-big-data-simegas-unity-catalog-rg.name
  location            = azurerm_resource_group.sasoleuw-big-data-simegas-unity-catalog-rg.location
  identity {
    type              = "UserAssigned"
    identity_ids      = [azurerm_user_assigned_identity.sasoleuw-simegas-catalog-id.id]
  }
}

// Storage credential creation to be used to "CREATE_ external location
resource "databricks_storage_credential" "sasoleuw-simegas-dbsc-ai" {
  provider     = databricks.workspace
  name                  = "sasoleuw-simegas-dbsc-ai"
  azure_managed_identity {
    access_connector_id = azurerm_databricks_access_connector.sasoleuw-simegas-catalog-conncetor.id
    managed_identity_id = azurerm_user_assigned_identity.sasoleuw-simegas-catalog-id.id
  }
  comment    = "Storage credential for all external locations"
}

resource "databricks_external_location" "ai-catalog-external-location" {
  provider        = databricks.workspace
  name            = "ai-catalog-external-location"
  url             = format("abfss://%s@%s.dfs.core.windows.net",
    azurerm_storage_container.aicontainer.name,
  azurerm_storage_account.sasoleuwsimegascatalog.name)
  credential_name = databricks_storage_credential.sasoleuw-simegas-dbsc-ai.id
  comment         = "External location used by catalog-external-location as root storage"
  depends_on = [
    databricks_metastore_assignment.metastore
  ]
}