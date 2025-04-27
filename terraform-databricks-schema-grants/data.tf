data "terraform_remote_state" "catalog_schemas" {
  backend = "azurerm"
  config = {
    resource_group_name  = "sasoleuw-big-data-dev-aes-terraform-rg"
    storage_account_name = "sasolterraform"
    container_name       = "sasol-sandbox-aes-dbw"
    key                  = "unity-catalog/terraform.tfstate"
  }
}

data "databricks_schemas" "schemas" {
  # Correct reference to the output "catalog_schemas" instead of "catalog_definitions"
  for_each = data.terraform_remote_state.catalog_schemas.outputs.catalog_schemas

  catalog_name = each.key
  provider     = databricks.workspace
}
