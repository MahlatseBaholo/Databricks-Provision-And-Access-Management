output "metastore_id" {
  value = databricks_metastore.metastore_azure_southafricanorth.id
}

output "workspace_id" {
  value = azurerm_databricks_workspace.workspace.id
}

output "storage_account_name" {
  value = azurerm_storage_account.sasolsansimegascatalog.name
}


output "unity_catalog_resource_group_name" {
  value = azurerm_resource_group.sasolsan-simegas-unity-catalog-rg.name
}

output "workspace_resource_group_name" {
  value = azurerm_resource_group.sasolsan-simegas-dev-rg.name
}

output "metastore_assignment" {
  value = databricks_metastore_assignment.metastore_azure_southafricanorth
}