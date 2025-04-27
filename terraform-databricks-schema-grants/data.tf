data "terraform_remote_state" "metastore" {
  backend = "azurerm"
  config = {
    resource_group_name  = "sasoleuw-big-data-dev-aes-terraform-rg"
    storage_account_name = "sasolterraform"
    container_name       = "sasol-sandbox-aes-dbw"
    key                  = "unity-catalog/terraform.tfstate"
  }
}

data "databricks_schemas" "schemas" {
  for_each = var.catalog_definitions
  catalog_name = each.key

  provider = databricks.workspace
}
