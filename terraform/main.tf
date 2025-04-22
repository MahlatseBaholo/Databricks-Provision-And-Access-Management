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

module "databricks_workspace" {
  source                        = "./modules/databricks_workspace"
  resource_group_name_workspace = var.databricks_workspace_name
  location                      = var.location
  resource_group_name           = module.workspace_rg.name
}