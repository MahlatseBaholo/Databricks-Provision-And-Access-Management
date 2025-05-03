terraform {
  backend "azurerm" {
    resource_group_name  = "sasolsan-simegas-qa-terraform-rg"
    storage_account_name = "sasolsansimegascatalog"
    container_name       = "shared-components"
    key                  = "metastoreazuresan/terraform.tfstate"
  }
}