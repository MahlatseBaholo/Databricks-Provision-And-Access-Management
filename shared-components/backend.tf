terraform {
  backend "azurerm" {
    resource_group_name  = "sasoleuw-simegas-dev-rg"
    storage_account_name = "sasoldevsimegasterraform"
    container_name       = "shared-components"
    key                  = "manage/terraform.tfstate"
  }
}