terraform {
  backend "azurerm" {
    resource_group_name  = "sasolsan-simegas-unity-catalog-rg"
    storage_account_name = "sasolsansimegasterraform"
    container_name       = "shared-components"
    key                  = "metastoreazuresan/terraform.tfstate"
  }
}