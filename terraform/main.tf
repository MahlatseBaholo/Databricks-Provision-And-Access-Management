# Resource Groups
module "resource_groups" {
  source                        = "./modules/resource_groups"
  region                        = var.region
  resource_group_name_workspace = var.resource_group_name_workspace  # Provide the missing argument
}


# Databricks Workspace
module "workspace" {
  provider                            = azurerm
  source                              = "./modules/databricks_workspace"
  region                          = var.region
  resource_group_name_workspace = module.resource_groups.workspace_rg_name
  workspace_name                      = var.workspace_name
}

# Storage Account & Container
module "storage" {
  source                                = "./modules/storage"
  resource_group_name_storage_account   = module.resource_groups.storage_account_rg_name
  region                                = var.region
  storage_account                       = var.storage_account_name
  container_name                        = var.container_name
}

