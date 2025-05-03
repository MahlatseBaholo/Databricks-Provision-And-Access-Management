resource "azurerm_resource_group" "sasolsan-simegas-prod-rg" {
  name     = "sasolsan-simegas-prod-rg"
  location = "southafricanorth" 
}

resource "azurerm_databricks_workspace" "sasol-prod-simegas-dbw" {
  name                = "sasol-prod-simegas-dbw"
  location            = azurerm_resource_group.sasolsan-simegas-prod-rg.location
  resource_group_name = azurerm_resource_group.sasolsan-simegas-prod-rg.name
  sku                 = "premium"
}

resource "azurerm_resource_group" "sasolsan-simegas-prod-terraform-rg" {
  name     = "sasolsan-simegas-prod-terraform-rg"
  location = "southafricanorth"
}

resource "azurerm_storage_account" "sasolprodsimegastf" {
  name                     = "sasolprodsimegastf"
  resource_group_name      = azurerm_resource_group.sasolsan-simegas-prod-terraform-rg.name
  location                 = azurerm_resource_group.sasolsan-simegas-prod-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "sasol-prod-simegas-dbw" {
  name                  = "metastoreazuresan"
  storage_account_name  = azurerm_storage_account.sasolprodsimegastf.name
  container_access_type = "private"
}

resource "databricks_metastore" "metastore_azure_southafricanorth" {
  provider      = databricks.account
  name          = "metastore_azure_southafricanorth"
  location      = azurerm_resource_group.sasolsan-simegas-unity-catalog-rg.location
}

resource "databricks_metastore_assignment" "metastore_azure_southafricanorth" {
  provider      = databricks.account
  metastore_id  = databricks_metastore.metastore_azure_southafricanorth.id
  workspace_id  = azurerm_databricks_workspace.sasol-prod-simegas-dbw.id
}