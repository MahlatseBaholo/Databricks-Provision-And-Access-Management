output "schemas" {
  value = { 
    for catalog_name, catalog_data in databricks_catalog_with_access : 
    catalog_name => catalog_data.schemas 
  }
}
