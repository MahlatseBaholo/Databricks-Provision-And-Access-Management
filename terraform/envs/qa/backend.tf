terraform {
  backend "azurerm" {
    resource_group_name  = "sasolsan-simegas-qa-terraform-rg"
    storage_account_name = "sasolqasimegasterraform"
    container_name       = "sasol-qa-simegas-dbw"
    key                  = "manage/terraform.tfstate"
  }
}