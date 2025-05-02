data "databricks_group" "groups" {
  for_each = toset(var.group_names)

  provider     = databricks.account
  display_name = each.value
}

data "terraform_remote_state" "metastore" {
  backend = "azurerm"
  config = {
    resource_group_name  = "sasolsan-simegas-$(env)-terraform-rg"
    storage_account_name = "sasol$(env)simegasterraform"
    container_name       = "shared-components"
    key                  = "metastoreazuresan/terraform.tfstate"
  }
}