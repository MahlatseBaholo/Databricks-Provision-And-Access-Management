terraform {
  backend "azurerm" {
    resource_group_name  = "sasolsan-simegas-$(env)-terraform-rg"
    storage_account_name = "sasol$(env)simegasterraform"
    container_name       = "sasol-$(env)-simegas-dbw"
    key                  = "manage/terraform.tfstate"
  }
}