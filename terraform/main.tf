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
  source                        = "./modules/databricks_workspace"
  name                          = var.databricks_workspace_name
  location                      = var.location
  resource_group_name_workspace = module.workspace_rg.name
}

resource "databricks_metastore_assignment" "metastore" {
  metastore_id = var.metastore_id
  workspace_id = var.workspace_id
  #default_catalog_name = "main"
}

resource "databricks_metastore" "metastore" {
  provider      = databricks.azure_account
  name          = "metastore"
  storage_root  = "abfss://metastore@sasoleuwaescatalog.dfs.core.windows.net/managed-tables/88ad67c1-2d9f-448a-a740-155002742426"
  owner         = "MetastoreAdmins"
  region        = var.location
}

module "metastore_assignment" {
  source       = "./modules/metastore_assignment"
  providers = {
    databricks.azure_account = databricks.azure_account
  }
  metastore_id = data.terraform_remote_state.metastore.outputs.metastore_id
  workspace_id = module.databricks_workspace.workspace_id
}
