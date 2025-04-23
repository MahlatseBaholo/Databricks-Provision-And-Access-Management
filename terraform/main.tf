module "metastore_assignment" {
  source       = "./module/metastore_assignment"
  providers = {
    databricks.azure_account = databricks.azure_account
  }
  metastore_id = data.terraform_remote_state.metastore.outputs.metastore_id
  workspace_id = data.terraform_remote_state.metastore.outputs.workspace_id
}

module "storage_credential" {
  source              = "./module/databricks_storage_credential"
  name                = var.databricks_storage_credential_name
  access_connector_id = data.terraform_remote_state.metastore.outputs.access_connector_id
  managed_identity_id = data.terraform_remote_state.metastore.outputs.user_assigned_identity_id

  providers = {
    databricks.workspace = databricks.workspace
  }
}

module "sandbox_external_location" {
  source          = "./module/databricks_external_location"
  name            = var.databricks_databricks_external_location
  url             = format("abfss://%s@%s.dfs.core.windows.net",
                      module.shared_components.sandbox_container_name,
                      module.shared_components.storage_account_name)
  credential_name = module.storage_credential.storage_credential_id
  comment         = "External location used by catalog-external-location as root storage"

  depends_on = [module.metastore_assignment]
}

