terraform {
  backend "azurerm" {
    resource_group_name  = "sasolsan-simegas-prod-terraform-rg"
    storage_account_name = "sasolprodsimegastf"
    container_name       = "sasol-prod-simegas-dbw"
    key                  = "databricks-metastore-assignment/terraform.tfstate"
  }
}