terraform {
  backend "azurerm" {
    resource_group_name  = "sasoleuw-big-data-preprod-aes-terraform-rg"
    storage_account_name = "sasolpreprodterraform"
    container_name       = "sasol-preprod-aes3-dbw"
    key                  = "databricks-metastore-assignment/terraform.tfstate"
    use_azuread_auth     = true
  }
}