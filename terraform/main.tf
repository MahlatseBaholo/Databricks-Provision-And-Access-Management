module "storage_container" {
  source = "./module/storage_container"
  for_each = var.storage_definitions
  name                 = each.value.container_name
  storage_account_name = data.terraform_remote_state.metastore.outputs.storage_account_name
  resource_group_name  = data.terraform_remote_state.metastore.outputs.unity_catalog_resource_group_name
}

module "storage_credential" {
  source = "./module/databricks_storage_credential"
  for_each = var.storage_definitions
  name                = each.value.storage_credential_name
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
  source  = "./module/databricks_external_location"
  for_each = var.storage_definitions
  name             = each.value.external_location_name
  url              = format("abfss://%s@%s.dfs.core.windows.net",
    module.storage_container[each.key].container_name,
  data.terraform_remote_state.metastore.outputs.storage_account_name)
  credential_name = module.storage_credential[each.key].storage_credential_id
  depends_on = [
    null_resource.metastore_assignment_dependency
  ]
  providers = {
    databricks.workspace = databricks.workspace
  }
}

resource "databricks_catalog" "this" {
  name = var.catalog_name
}

resource "databricks_grants" "catalog" {
  catalog = databricks_catalog.this.name

  dynamic "grant" {
    for_each = var.catalog_access
    content {
      principal  = grant.key
      privileges = grant.value
    }
  }
}

resource "databricks_schema" "this" {
  for_each    = toset(var.schema_names)
  name        = each.key
  catalog_name = databricks_catalog.this.name
}

resource "databricks_grants" "schema" {
  for_each = var.schema_access

  schema = databricks_schema[each.key].name
  catalog = databricks_catalog.this.name

  dynamic "grant" {
    for_each = each.value
    content {
      principal  = grant.key
      privileges = grant.value
    }
  }
}


