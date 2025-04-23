output "metastore_id" {
  value = databricks_metastore.metastore.id
}

output "workspace_id" {
  value = azurerm_databricks_workspace.workspace.id
}

output "storage_account_name" {
  value = azurerm_storage_account.sasoleuwaescatalog.name
}



