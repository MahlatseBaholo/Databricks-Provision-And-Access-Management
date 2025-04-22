terraform {
  backend "azurerm" {
    resource_group_name  = "sasoleuw-simegas-dev-rg"
    storage_account_name = "simegas-terraform-backend"
    container_name       = "databricks"
    key                  = "terraform-databricks.tfstate"
    access_key           = ""
  }

}