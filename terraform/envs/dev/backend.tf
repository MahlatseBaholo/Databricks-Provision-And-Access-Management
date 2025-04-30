terraform {
  backend "azurerm" {
    resource_group_name  = "sasoleuw-simegas-dev-rg"
    storage_account_name = "sasoldevsimegasterraform"
    container_name       = "sasol-dev-simegas-dbw"
    key                  = "manage/terraform.tfstate"
  }
}