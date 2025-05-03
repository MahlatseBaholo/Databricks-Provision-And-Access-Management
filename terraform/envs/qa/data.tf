data "databricks_group" "groups" {
  for_each = toset(var.group_names)

  provider     = databricks.workspace
  display_name = each.value
}

data "terraform_remote_state" "metastoreazuresan" {
  backend = "azurerm"
  config = {
    resource_group_name  = "sasolsan-simegas-unity-catalog-rg"
    storage_account_name = "sasolsansimegasterraform"
    container_name       = "shared-components"
    key                  = "metastoreazuresan/terraform.tfstate"
  }
}

data "terraform_remote_state" "databricks-metastore-assignment" {
  backend = "azurerm"
  config = {
    resource_group_name  = "sasolsan-simegas-qa-terraform-rg"
    storage_account_name = "sasolqasimegastf"
    container_name       = "sasol-qa-simegas-dbw"
    key                  = "databricks-metastore-assignment/terraform.tfstate"
  }
}