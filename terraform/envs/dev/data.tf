data "databricks_group" "groups" {
  for_each = toset(var.group_names)  # Use the group names from the variable

  provider     = databricks.account
  display_name = each.value  # Fetch the group by display name
}

data "terraform_remote_state" "metastore" {
  backend = "azurerm"
  config = {
    resource_group_name  = "sasoleuw-big-data-dev-aes-terraform-rg"
    storage_account_name = "sasoldevterraform"
    container_name       = "shared-components"
    key                  = "metastore/terraform.tfstate"
  }
}