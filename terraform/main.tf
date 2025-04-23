module "storage_credential" {
  source              = "./module/databricks_storage_credential"
  name                = var.databricks_storage_credential_name
  access_connector_id = data.terraform_remote_state.metastore.outputs.access_connector_id
  managed_identity_id = data.terraform_remote_state.metastore.outputs.user_assigned_identity_id

  providers = {
    databricks.workspace = databricks.workspace
  }
}

module "external_location" {
  source           = "./module/databricks_external_location"
  name             = var.databricks_databricks_external_location
  credential_name  = module.storage_credential.storage_credential_id
  container_name   = data.terraform_remote_state.metastore.outputs.storage_container_name
  storage_account  = data.terraform_remote_state.metastore.outputs.storage_account_name

  metastore_assignment_depends_on = data.terraform_remote_state.metastore.outputs.metastore_assignment

  providers = {
    databricks.workspace = databricks.workspace
  }
}

