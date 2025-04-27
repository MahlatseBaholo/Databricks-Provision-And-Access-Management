terraform {
  backend "azurerm" {
    resource_group_name  = "sasoleuw-big-data-dev-aes-terraform-rg"
    storage_account_name = "sasoldevterraform"
    container_name       = "sasol-sandbox-aes-dbw"
    key                  = "catalog/terraform.tfstate"
    access_key           = "sxk5ABUn3ft2pLSwj740BJNAMEPyAfB7PRlM7gwltYLVuMgVxJzDAZtJxK6uYygICwTNIBlo3dLt+AStgeNOTQ=="
  }
}