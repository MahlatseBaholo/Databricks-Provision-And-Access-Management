terraform {
  backend "azurerm" {
    resource_group_name  = "sasolsan-simegas-dev-terraform-rg"
    storage_account_name = "sasoldevsimegastf"
    container_name       = "shared-components"
    key                  = "metastoreazuresan/terraform.tfstate"
  }
}