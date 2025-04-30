terraform {
  backend "azurerm" {
    resource_group_name  = "sasolsan-simegas-dev-terraform-rg"
    storage_account_name = "sasoldevsimegasterraform"
    container_name       = "sasol-dev-simegas-dbw"
    key                  = "manage/terraform.tfstate"
  }
}