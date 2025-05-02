resource "azurerm_resource_group" "sasolsan-simegas-unity-catalog-rg" {
  name     = "sasolsan-simegas-unity-catalog-rg"
  location = "southafricanorth"
}


resource "azurerm_resource_group" "sasolsan-simegas-dev-rg" {
  name     = "sasolsan-simegas-dev-rg"
  location = "southafricanorth"
}

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

resource "azurerm_storage_container" "metastoreazuresan" {
  name                  = "metastoreazuresan"
  storage_account_name  = azurerm_storage_account.sasolsansimegascatalog.name
  container_access_type = "private"
}

resource "databricks_metastore" "metastore_azure_southafricanorth" {
  provider      = databricks.account
  name          = "metastore_azure_southafricanorth"
  #storage_root  = "abfss://metastore_azure_southafricanorth@sasolsansimegascatalog.dfs.core.windows.net/managed-tables/88ad67c1-2d9f-448a-a740-155002742426"
  #owner         = "MetastoreAdmins"
  region        = "southafricanorth"
#  sku           = "premium"
}

resource "azurerm_databricks_workspace" "workspace" {
  name                = "sasol-simegas-dbw-rg"
  location            = "southafricanorth"
  resource_group_name = "sasolsan-simegas-dev-rg"
  sku                 = "premium"
}

resource "databricks_metastore_assignment" "metastore_azure_southafricanorth" {
  provider      = databricks.account
  metastore_id  = databricks_metastore.metastore_azure_southafricanorth.id
  workspace_id  = "1584894596117397"
}
