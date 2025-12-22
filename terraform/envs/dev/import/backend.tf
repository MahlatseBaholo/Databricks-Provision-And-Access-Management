terraform {
  backend "azurerm" {
    resource_group_name  = "sasoleuw-big-data-dev-aes-terraform-rg"
    storage_account_name = "sasoldevterraform"
    container_name       = "sasol-dev-aes2-dbw"
    key                  = "databricks-metastore-assignment/terraform.tfstate"
  }
}