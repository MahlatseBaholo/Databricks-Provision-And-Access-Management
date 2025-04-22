resource "azurerm_resource_group" "this" {
  name     = var.workspace_rg_name
  location = var.location
}

resource "azurerm_resource_group" "unity_catalog" {
  name     = var.storage_account_rg_name
  location = var.location
}
