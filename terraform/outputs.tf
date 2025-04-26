output "catalog_schemas" {
  value = {
    for catalog_name, schemas in data.databricks_schemas.schemas :
    catalog_name => schemas.schemas[*].name
  }
}
