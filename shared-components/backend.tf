terraform {
  backend "azurerm" {
    resource_group_name  = "sasolsan-simegas-dev-terraform-rg"
    storage_account_name = "sasoldevsimegasterraform"
    container_name       = "shared-components"
    key                  = "metastore_azure_southafricanorth/terraform.tfstate"
  }
}