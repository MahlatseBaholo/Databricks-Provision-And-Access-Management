terraform {
  backend "azurerm" {
    resource_group_name  = "sasolsan-simegas-$(var.env)-terraform-rg"
    storage_account_name = "sasol$(var.env)simegasterraform"
    container_name       = "sasol-$(var.env)-simegas-dbw"
    key                  = "manage/terraform.tfstate"
  }
}