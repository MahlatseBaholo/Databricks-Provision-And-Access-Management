module "storage_container" {
  source               = "./module/storage_container"
  name                 = var.storage_container
  storage_account_name = data.terraform_remote_state.metastore.outputs.storage_account_name
  resource_group_name  = data.terraform_remote_state.metastore.outputs.unity_catalog_resource_group_name
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

resource "null_resource" "metastore_assignment_dependency" {
  triggers = {
    metastore_assignment_id = data.terraform_remote_state.metastore.outputs.metastore_assignment.id
  }
}

module "external_location" {
  source           = "./module/databricks_external_location"
  name             = var.databricks_databricks_external_location
  url              = format("abfss://%s@%s.dfs.core.windows.net",
    module.storage_container.container_name,
  data.terraform_remote_state.metastore.outputs.storage_account_name)
  credential_name  = module.storage_credential.storage_credential_id
  depends_on = [
    null_resource.metastore_assignment_dependency
  ]
  providers = {
    databricks.workspace = databricks.workspace
  }
}
