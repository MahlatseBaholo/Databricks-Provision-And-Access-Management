resource "azurerm_storage_account" "example" {
  name                     = var.storage_account_name
  resource_group_name       = var.resource_group_name
  location                 = var.region
  account_tier              = "Standard"
  account_replication_type = "ZRS"
  is_hns_enabled           = true
}