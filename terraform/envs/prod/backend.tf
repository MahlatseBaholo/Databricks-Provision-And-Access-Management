terraform {
  backend "azurerm" {
    resource_group_name  = "sasoleuw-big-data-prod-aes-terraform-rg"
    storage_account_name = "sasolprodterraform"
    container_name       = "sasol-prod-aes3-dbw"
    key                  = "manage/terraform.tfstate"
    use_azuread_auth     = true
  }
}