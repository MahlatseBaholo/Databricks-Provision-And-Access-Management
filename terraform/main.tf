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
  url             = format("abfss://%s@%s.dfs.core.windows.net",
    azurerm_storage_container.var.storage_container,
  azurerm_storage_account.sasoleuwaescatalog.name)
  credential_name  = module.storage_credential.storage_credential_id
  storage_account  = data.terraform_remote_state.metastore.outputs.storage_account_name
  depends_on      = [
    data.terraform_remote_state.metastore.outputs.metastore_assignment
  ]
  providers = {
    databricks.workspace = databricks.workspace
  }
}

resource "databricks_external_location" "retail_backcourt-catalog-external-location" {
  provider        = databricks.workspace
  name            = "retail_backcourt-catalog-external-location"
  url             = format("abfss://%s@%s.dfs.core.windows.net",
    azurerm_storage_container.retail_backcourt.name,
  azurerm_storage_account.sasoleuwaescatalog.name)
  credential_name = databricks_storage_credential.sasoleuw-aes-dbsc-retail_backcourt.id
  comment         = "External location used by catalog-external-location as root storage"
  depends_on = [
    databricks_metastore_assignment.metastore
  ]
}

