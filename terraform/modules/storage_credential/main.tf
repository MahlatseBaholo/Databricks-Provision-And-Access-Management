provider "databricks" {
  alias = "workspace"
}

resource "databricks_storage_credential" "this" {
  name     = var.name
  comment  = var.comment

  azure_managed_identity {
    access_connector_id = var.access_connector_id
    managed_identity_id = var.managed_identity_id
  }
}
