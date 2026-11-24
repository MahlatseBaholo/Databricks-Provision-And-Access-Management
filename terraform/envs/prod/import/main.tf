resource "azurerm_resource_group" "sasoleuw-big-data-prod-aes-rg" {
  name     = "sasoleuw-big-data-prod-aes-rg"
  location = "westeurope" 
}

resource "azurerm_databricks_workspace" "sasol-prod-aes3-dbw" {
  name                = "sasol-prod-aes3-dbw"
  location            = azurerm_resource_group.sasoleuw-big-data-prod-aes-rg.location
  resource_group_name = azurerm_resource_group.sasoleuw-big-data-prod-aes-rg.name
  sku                 = "premium"
}

resource "azurerm_resource_group" "sasoleuw-big-data-prod-aes-terraform-rg" {
  name     = "sasoleuw-big-data-prod-aes-terraform-rg"
  location = "westeurope"
}

resource "azurerm_storage_account" "sasolprodterraform" {
  name                     = "sasolprodterraform"
  resource_group_name      = azurerm_resource_group.sasoleuw-big-data-prod-aes-terraform-rg.name
  location                 = azurerm_resource_group.sasoleuw-big-data-prod-aes-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "sasol-prod-aes3-dbw" {
  name                  = "metastore"
  storage_account_name  = azurerm_storage_account.sasolprodterraform.name
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
  workspace_id  = azurerm_databricks_workspace.sasol-prod-aes3-dbw.workspace_id
}