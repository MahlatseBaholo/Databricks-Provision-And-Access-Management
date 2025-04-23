module "workspace_rg" {
  source   = "./modules/resource_group"
  name     = var.resource_group_name_workspace
  location = var.location
}

module "catalog_rg" {
  source   = "./modules/resource_group"
  name     = var.resource_group_name_catalog
  location = var.location
}

module "databricks_workspace" {
  provider            = azurerm
  source                        = "./modules/databricks_workspace"
  name                          = var.databricks_workspace_name
  location                      = var.location
  resource_group_name_workspace = module.workspace_rg.name
}

module "metastore_assignment" {
  providers = {
    databricks = databricks.azure_account
  }
  source       = "./modules/metastore_assignment"
  metastore_id = data.terraform_remote_state.metastore.outputs.metastore_id
  workspace_id = data.terraform_remote_state.databricks_workspace.outputs.workspace_id
}