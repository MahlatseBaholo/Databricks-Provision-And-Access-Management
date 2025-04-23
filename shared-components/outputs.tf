output "metastore_id" {
  value = databricks_metastore.metastore.id
}

output "workspace_id" {
  value = azurerm_databricks_workspace.workspace.id
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

output "workspace_resource_group_name" {
  value = azurerm_resource_group.sasoleuw-big-data-sandbox-aes-rg.name
}

output "metastore_assignment" {
  value = databricks_metastore_assignment.metastore
}






