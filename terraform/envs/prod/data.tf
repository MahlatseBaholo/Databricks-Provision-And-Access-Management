data "databricks_group" "groups" {
  for_each = toset(var.group_names)

  provider     = databricks.workspace
  display_name = each.value
}

data "terraform_remote_state" "metastore" {
  backend = "azurerm"
  config = {
    resource_group_name  = "sasolsan-simegas-prod-terraform-rg"
    storage_account_name = "sasolprodsimegastf"
    container_name       = "shared-components"
    key                  = "metastoreazuresan/terraform.tfstate"
  }
}