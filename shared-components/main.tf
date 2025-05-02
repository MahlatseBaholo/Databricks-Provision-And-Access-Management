#resource "azurerm_resource_group" "sasolsan-simegas-dev-rg" {
#  name     = "sasolsan-simegas-dev-rg"
#  location = "southafricanorth"
#}

resource "azurerm_resource_group" "sasolsan-simegas-dev-terraform-rg" {
  name     = "sasolsan-simegas-dev-terraform-rg"
  location = "southafricanorth"
}

resource "azurerm_storage_account" "sasolsansimegascatalog" {
  name                      = "sasolsansimegascatalog"
  resource_group_name       = "sasolsan-simegas-unity-catalog-rg"
  location                  = azurerm_resource_group.sasolsan-simegas-unity-catalog-rg.location
  account_tier              = "Standard"
  account_replication_type  = "ZRS"
  is_hns_enabled            = true
}

resource "azurerm_storage_account" "sasoldevsimegasterraform" {
  name                      = "sasoldevsimegasterraform"
  resource_group_name       = "sasolsan-simegas-dev-terraform-rg"
  location                  = azurerm_resource_group.sasolsan-simegas-dev-terraform-rg.location
  account_tier              = "Standard"
  account_replication_type  = "ZRS"
  is_hns_enabled            = true
}

resource "azurerm_storage_container" "metastore" {
  name                  = "metastore"
  storage_account_name  = azurerm_storage_account.sasolsansimegascatalog.name
  container_access_type = "private"
}

#resource "databricks_metastore" "metastore" {
#  provider      = databricks.azure_account
#  name          = "metastore"
#  storage_root  = "abfss://metastore@sasolsansimegascatalog.dfs.core.windows.net/managed-tables/88ad67c1-2d9f-448a-a740-155002742426"
  #owner         = "MetastoreAdmins"
#  region        = "southafricanorth"
#  sku           = "premium"
}

#resource "azurerm_databricks_workspace" "workspace" {
#  name                = var.name
#  location            = var.location
#  resource_group_name = var.resource_group_name_workspace
#  sku                 = "premium"
#}

#resource "databricks_metastore_assignment" "metastore" {
#  provider      = databricks.azure_account
#  metastore_id  = databricks_metastore.metastore.id
#  workspace_id  = "3212216276919665"
#}

resource "azurerm_user_assigned_identity" "sasolsan-simegas-catalog-id" {
  name                = "sasolsan-simegas-catalog-id"
  location            = azurerm_resource_group.sasolsan-simegas-unity-catalog-rg.location
  resource_group_name = azurerm_resource_group.sasolsan-simegas-unity-catalog-rg.name
}

resource "azurerm_databricks_access_connector" "sasolsan-simegas-catalog-connector" {
  name                = "sasolsan-simegas-catalog-connector"
  resource_group_name = azurerm_resource_group.sasolsan-simegas-unity-catalog-rg.name
  location            = azurerm_resource_group.sasolsan-simegas-unity-catalog-rg.location
  identity {
    type              = "UserAssigned"
    identity_ids      = [azurerm_user_assigned_identity.sasolsan-simegas-catalog-id.id]
  }
}