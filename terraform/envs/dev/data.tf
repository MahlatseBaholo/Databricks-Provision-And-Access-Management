data "databricks_group" "groups" {
  for_each = toset(var.group_names)

  provider     = databricks.workspace
  display_name = each.value
}

data "terraform_remote_state" "metastore" {
  backend = "azurerm"
  config = {
    resource_group_name  = "sasoleuw-big-data-aes-unity-catalog-rg"
    storage_account_name = "sasoleuaes3terraform"
    container_name       = "shared-components"
    key                  = "metastore/terraform.tfstate"
    use_azuread_auth     = true
  }
}

data "terraform_remote_state" "databricks-metastore-assignment" {
  backend = "azurerm"
  config = {
    resource_group_name  = "sasoleuw-big-data-dev-aes-terraform-rg"
    storage_account_name = "sasoldevterraform"
    container_name       = "sasol-dev-aes3-dbw"
    key                  = "databricks-metastore-assignment/terraform.tfstate"
    use_azuread_auth     = true
  }
}