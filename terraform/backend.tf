terraform {
  backend "azurerm" {
    resource_group_name  = "sasoleuw-big-data-dev-aes-terraform-rg"
    storage_account_name = "sasolterraform"
    container_name       = "shared-components"
    key                  = "metastore/terraform.tfstate"
    access_key           = "BwPZlGrsD3EQn4B1ZrZxbPqK+51F+DuhQUYXUInfjtYgwtAx6mEzUNd+p+NZNWREiLsulbaJFBC2+ASth6AtRg=="
  }
}