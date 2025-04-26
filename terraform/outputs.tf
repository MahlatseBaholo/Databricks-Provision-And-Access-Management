output "catalog_schemas" {
  value = {
    for catalog_name, schemas_data in data.databricks_schemas.schemas :
    catalog_name => schemas_data[*].name
  }
}
