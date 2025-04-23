module "workspace_rg" {
  source   = "./module/resource_group"
  providers = {
    azurerm = azurerm
  }
  name     = var.resource_group_name_workspace
  location = var.location
}

module "catalog_rg" {
  source   = "./module/resource_group"
  name     = var.resource_group_name_catalog
  location = var.location
}

module "databricks_workspace" {
  source                        = "./module/databricks_workspace"
  name                          = var.databricks_workspace_name
  location                      = var.location
  resource_group_name_workspace = module.workspace_rg.name
}

module "metastore_assignment" {
  source       = "./module/metastore_assignment"
  providers = {
    databricks.azure_account = databricks.azure_account
  }
  metastore_id = data.terraform_remote_state.metastore.outputs.metastore_id
  workspace_id = module.databricks_workspace.workspace_id
}
