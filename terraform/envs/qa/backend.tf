terraform {
  backend "azurerm" {
    resource_group_name  = "sasoleuw-big-data-preprod-aes-terraform-rg"
    storage_account_name = "sasolqaterraform"
    container_name       = "sasol-qa-aes3-dbw"
    key                  = "manage/terraform.tfstate"
    use_azuread_auth     = true
  }
}