resource "azurerm_resource_group" "simegas_dev" {
  name     = var.dev_rg_name
  location = var.location
}

resource "azurerm_resource_group" "unity_catalog" {
  name     = var.uc_rg_name
  location = var.location
}
