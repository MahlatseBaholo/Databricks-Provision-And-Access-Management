data "terraform_remote_state" "metastore" {
  backend = "azurerm"
  config = {
    resource_group_name  = "sasoleuw-big-data-dev-aes-terraform-rg"
    storage_account_name = "sasolterraform"
    container_name       = "shared-components"
    key                  = "metastore/terraform.tfstate"
  }
}
