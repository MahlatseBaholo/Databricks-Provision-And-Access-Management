output "metastore_id" {
  value = databricks_metastore.metastore_azure_southafricanorth.id
}

output "databricks-metastore-assignment" {
  value = databricks_metastore_assignment.metastore_azure_southafricanorth
}