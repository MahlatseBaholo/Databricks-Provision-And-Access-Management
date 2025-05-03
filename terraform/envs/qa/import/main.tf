resource "azurerm_resource_group" "sasolsan-simegas-dev-rg" {
  name     = "sasolsan-simegas-dev-rg"
  location = "southafricanorth" 
}

resource "azurerm_databricks_workspace" "sasol-dev-simegas-dbw" {
  name                = "sasol-dev-simegas-dbw"
  location            = azurerm_resource_group.sasolsan-simegas-dev-rg.location
  resource_group_name = azurerm_resource_group.sasolsan-simegas-dev-rg.name
  sku                 = "premium"
}

resource "azurerm_resource_group" "sasolsan-simegas-dev-terraform-rg" {
  name     = "sasolsan-simegas-dev-terraform-rg"
  location = "southafricanorth"
}

resource "azurerm_storage_account" "sasoldevsimegastf" {
  name                     = "sasoldevsimegastf"
  resource_group_name      = azurerm_resource_group.sasolsan-simegas-dev-terraform-rg.name
  location                 = azurerm_resource_group.sasolsan-simegas-dev-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "sasol-dev-simegas-dbw" {
  name                  = "metastoreazuresan"
  storage_account_name  = azurerm_storage_account.sasoldevsimegastf.name
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
  workspace_id  = azurerm_databricks_workspace.sasol-dev-simegas-dbw.id
}