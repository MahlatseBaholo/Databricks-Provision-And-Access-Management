data "terraform_remote_state" "metastore" {
  backend = "azurerm"
  config = {
    resource_group_name  = "sasoleuw-big-data-dev-aes-terraform-rg"
    storage_account_name = "sasolterraform"
    container_name       = "shared-components"
    key                  = "metastore/terraform.tfstate"
  }
}

data "databricks_schemas" "schemas" {
  for_each = local.enriched_catalog_definitions
  catalog_name = each.key

  depends_on = [
    module.databricks_catalog_with_access
  ]

  provider = databricks.workspace
}
