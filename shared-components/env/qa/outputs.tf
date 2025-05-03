output "workspace_resource_group_name" {
  value = azurerm_resource_group.sasolsan-simegas-dev-rg.name
}

output "workspace_id" {
  value = azurerm_databricks_workspace.sasol-dev-simegas-dbw.id
}

output "workspace_resource_group_name" {
  value = azurerm_resource_group.sasolsan-simegas-qa-rg.name
}

output "workspace_id" {
  value = azurerm_databricks_workspace.sasol-qa-simegas-dbw.id
}

output "workspace_resource_group_name" {
  value = azurerm_resource_group.sasolsan-simegas-prod-rg.name
}

output "workspace_id" {
  value = azurerm_databricks_workspace.sasol-prod-simegas-dbw.id
}

output "unity_catalog_resource_group_name" {
  value = azurerm_resource_group.sasolsan-simegas-unity-catalog-rg.name
}

output "storage_account_name" {
  value = azurerm_storage_account.sasolsansimegascatalog.name
}

output "user_assigned_identity_id" {
  value = azurerm_user_assigned_identity.sasolsan-simegas-catalog-id.id
}

output "user_assigned_identity_name" {
  value = azurerm_user_assigned_identity.sasolsan-simegas-catalog-id.name
}

output "access_connector_id" {
  value = azurerm_databricks_access_connector.sasolsan-simegas-catalog-connector.id
}

output "access_connector_name" {
  value = azurerm_databricks_access_connector.sasolsan-simegas-catalog-connector.name
} 

output "metastore_id" {
  value = databricks_metastore.metastore_azure_southafricanorth.id
}

output "metastore_assignment" {
  value = databricks_metastore_assignment.metastore_azure_southafricanorth
}