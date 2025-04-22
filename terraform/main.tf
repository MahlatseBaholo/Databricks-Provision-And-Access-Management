module "azurerm_resource_group" "sasoleuw-big-data-sandbox-aes-rg" {
  source = "./modules/resource_groups"
  name     = var.resource_group_name
  location = var.location
}
