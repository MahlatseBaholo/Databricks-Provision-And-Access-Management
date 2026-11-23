terraform {
  backend "azurerm" {
    resource_group_name  = "sasoleuw-big-data-dev-aes-terraform-rg"
    storage_account_name = "sasoldevterraform"
    container_name       = "sasol-dev-aes3-dbw"
    key                  = "manage/terraform.tfstate"
    use_azuread_auth     = true
  }
}