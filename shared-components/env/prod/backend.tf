terraform {
  backend "azurerm" {
    resource_group_name  = "sasolsan-simegas-prod-terraform-rg"
    storage_account_name = "sasolprodsimegasterraform"
    container_name       = "shared-components"
    key                  = "metastoreazuresan/terraform.tfstate"
  }
}