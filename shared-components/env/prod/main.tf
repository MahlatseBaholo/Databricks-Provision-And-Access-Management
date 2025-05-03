resource "azurerm_resource_group" "sasolsan-simegas-prod-rg" {
  name     = "sasolsan-simegas-prod-rg"
  location = "southafricanorth"
}

resource "azurerm_resource_group" "sasolsan-simegas-prod-terraform-rg" {
  name     = "sasolsan-simegas-prod-terraform-rg"
  location = "southafricanorth"
}

resource "azurerm_resource_group" "sasolsan-simegas-unity-catalog-rg" {
  name     = "sasolsan-simegas-unity-catalog-rg"
  location = "southafricanorth"
}

resource "azurerm_storage_account" "sasolsansimegascatalog" {
  name                      = "sasolsansimegascatalog"
  resource_group_name       = "sasolsan-simegas-unity-catalog-rg"
  location                  = azurerm_resource_group.sasolsan-simegas-unity-catalog-rg.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  is_hns_enabled            = true
}

resource "azurerm_storage_account" "sasolprodsimegastf" {
  name                      = "sasolprodsimegastf"
  resource_group_name       = "sasolsan-simegas-prod-terraform-rg"
  location                  = azurerm_resource_group.sasolsan-simegas-prod-terraform-rg.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
}

resource "azurerm_storage_container" "metastoreazuresan" {
  name                  = "metastoreazuresan"
  storage_account_name  = azurerm_storage_account.sasolsansimegascatalog.name
  container_access_type = "private"
}

resource "databricks_metastore" "metastore_azure_southafricanorth" {
  provider      = databricks.account
  name          = "metastore_azure_southafricanorth"
  region        = "southafricanorth"
}

resource "azurerm_databricks_workspace" "sasol-prod-simegas-dbw" {
  name                = "sasol-prod-simegas-dbw"
  location            = "southafricanorth"
  resource_group_name = "sasolsan-simegas-prod-rg"
  sku                 = "premium"
}

resource "databricks_metastore_assignment" "metastore_azure_southafricanorth" {
  provider      = databricks.account
  metastore_id  = databricks_metastore.metastore_azure_southafricanorth.id
  workspace_id  = "1910321470216143"
}

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