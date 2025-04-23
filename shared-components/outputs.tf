output "metastore_id" {
  value = databricks_metastore.metastore.id
}

output "workspace_id" {
  value = azurerm_databricks_workspace.workspace.id
}

output "unity_catalog_rg_name" {
  value = azurerm_resource_group.unity-catalog-rg.name
}



