resource "azurerm_resource_group" "sasolsan-simegas-unity-catalog-rg" {
  name     = "sasolsan-simegas-unity-catalog-rg"
  location = "southafricanorth"
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