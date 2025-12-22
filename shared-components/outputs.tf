output "unity_catalog_resource_group_name" {
  value = azurerm_resource_group.sasoleuw-big-data-aes-unity-catalog-rg.name
}

output "storage_account_name" {
  value = azurerm_storage_account.sasoleuwaescatalog.name
}

output "user_assigned_identity_id" {
  value = azurerm_user_assigned_identity.sasoleuw-aes-catalog-id.id
}

output "user_assigned_identity_name" {
  value = azurerm_user_assigned_identity.sasoleuw-aes-catalog-id.name
}

output "access_connector_id" {
  value = azurerm_databricks_access_connector.sasoleuw-aes-catalog-conncetor.id
}

output "access_connector_name" {
  value = azurerm_databricks_access_connector.sasoleuw-aes-catalog-conncetor.name
}