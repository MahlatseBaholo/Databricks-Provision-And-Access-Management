data "terraform_remote_state" "metastore" {
  backend = "azurerm"
  config = {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstatestore"
    container_name       = "tfstate"
    key                  = "metastore/terraform.tfstate"
  }
}