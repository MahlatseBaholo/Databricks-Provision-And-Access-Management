resource "azurerm_resource_group" "sasoleuw-big-data-dev-aes-rg" {
  name     = "sasoleuw-big-data-dev-aes-rg"
  location = "westeurope" 
}

resource "azurerm_databricks_workspace" "sasol-dev-aes3-dbw" {
  name                = "sasol-dev-aes3-dbw"
  location            = azurerm_resource_group.sasoleuw-big-data-dev-aes-rg.location
  resource_group_name = azurerm_resource_group.sasoleuw-big-data-dev-aes-rg.name
  sku                 = "premium"
}

resource "azurerm_resource_group" "sasoleuw-big-data-dev-aes-terraform-rg" {
  name     = "sasoleuw-big-data-dev-aes-terraform-rg"
  location = "westeurope"
}

resource "azurerm_storage_account" "sasoldevterraform" {
  name                     = "sasoldevterraform"
  resource_group_name      = azurerm_resource_group.sasoleuw-big-data-dev-aes-terraform-rg.name
  location                 = azurerm_resource_group.sasoleuw-big-data-dev-aes-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "sasol-dev-aes3-dbw" {
  name                  = "metastore"
  storage_account_name  = azurerm_storage_account.sasoldevterraform.name
  container_access_type = "private"
}

resource "databricks_metastore" "metastore" {
  provider      = databricks.account
  name          = "metastore"
  location      = azurerm_resource_group.sasoleuw-big-data-aes-unity-catalog-rg.location
}

resource "databricks_metastore_assignment" "metastore" {
  provider      = databricks.account
  metastore_id  = databricks_metastore.metastore.id
  workspace_id  = azurerm_databricks_workspace.sasol-dev-aes3-dbw.workspace_id
}