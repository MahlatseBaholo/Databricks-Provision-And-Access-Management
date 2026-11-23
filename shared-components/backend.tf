terraform {
  backend "azurerm" {
    resource_group_name  = "sasoleuw-big-data-aes-unity-catalog-rg"
    storage_account_name = "sasoleuaes3terraform"
    container_name       = "shared-components"
    key                  = "metastore/terraform.tfstate"
  }
}