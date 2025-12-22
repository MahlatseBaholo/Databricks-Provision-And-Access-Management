resource "azurerm_resource_group" "sasoleuw-big-data-aes-unity-catalog-rg" {
  name     = "sasoleuw-big-data-aes-unity-catalog-rg"
  location = "westeurope"
}

resource "azurerm_storage_account" "sasoldevterraform" {
  name                      = "sasoldevterraform"
  resource_group_name       = azurerm_resource_group.sasoleuw-big-data-aes-unity-catalog-rg.name
  location                  = azurerm_resource_group.sasoleuw-big-data-aes-unity-catalog-rg.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  is_hns_enabled            = true
}

resource "azurerm_storage_container" "shared-components" {
  name                  = "shared-components"
  storage_account_name  = azurerm_storage_account.sasoldevterraform.name
  container_access_type = "private"
}

resource "azurerm_storage_account" "sasoleuwaescatalog" {
  name                      = "sasoleuwaescatalog"
  resource_group_name       = azurerm_resource_group.sasoleuw-big-data-aes-unity-catalog-rg.name
  location                  = azurerm_resource_group.sasoleuw-big-data-aes-unity-catalog-rg.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  is_hns_enabled            = true
}

resource "azurerm_storage_container" "metastore" {
  name                  = "metastore"
  storage_account_name  = azurerm_storage_account.sasoleuwaescatalog.name
  container_access_type = "private"
}

resource "azurerm_user_assigned_identity" "sasoleuw-aes-catalog-id" {
  name                = "sasoleuw-aes-catalog-id"
  location            = azurerm_resource_group.sasoleuw-big-data-aes-unity-catalog-rg.location
  resource_group_name = azurerm_resource_group.sasoleuw-big-data-aes-unity-catalog-rg.name
}

resource "azurerm_databricks_access_connector" "sasoleuw-aes-catalog-conncetor" {
  name                = "sasoleuw-aes-catalog-conncetor"
  resource_group_name = azurerm_resource_group.sasoleuw-big-data-aes-unity-catalog-rg.name
  location            = azurerm_resource_group.sasoleuw-big-data-aes-unity-catalog-rg.location
  identity {
    type              = "UserAssigned"
    identity_ids      = [azurerm_user_assigned_identity.sasoleuw-aes-catalog-id.id]
  }
}