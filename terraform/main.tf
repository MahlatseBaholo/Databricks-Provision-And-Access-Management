module "workspace_rg" {
  source  = "./modules/resource_group"
  name    = var.resource_group_name_workspace
  location = var.location
}

module "catalog_rg" {
  source  = "./modules/resource_group"
  name    = var.resource_group_name_catalog
  location = var.location
}
