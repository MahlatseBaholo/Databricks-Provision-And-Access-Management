data "databricks_group" "groups" {
  for_each = toset(var.group_names)

  provider     = databricks.workspace
  display_name = each.value
}

data "terraform_remote_state" "metastore" {
  backend = "azurerm"
  config = {
    resource_group_name  = "sasoleuw-big-data-aes-unity-catalog-rg"
    storage_account_name = "sasoleuaes2terraform"
    container_name       = "shared-components"
    key                  = "metastore/terraform.tfstate"
  }
}

data "terraform_remote_state" "databricks-metastore-assignment" {
  backend = "azurerm"
  config = {
    resource_group_name  = "sasoleuw-big-data-dev-aes-terraform-rg"
    storage_account_name = "sasoldevterraform"
    container_name       = "sasol-dev-aes2-dbw"
    key                  = "databricks-metastore-assignment/terraform.tfstate"
  }
}