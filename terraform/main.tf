locals {
  storage_definitions = {
    for catalog_name, _ in var.catalog_definitions : catalog_name => {
      container_name          = catalog_name
      storage_credential_name = "sasoleuw-aes-dbsc-${catalog_name}"
      external_location_name  = "${catalog_name}-catalog-external-location"
    }
  }

  enriched_catalog_definitions = {
    for catalog_name, def in var.catalog_definitions : catalog_name => merge(def, {
      storage_root = module.external_location[catalog_name].external_location_url
    })
  }
}

module "storage_container" {
  source = "./module/storage_container"
  for_each = local.storage_definitions
  name                 = each.value.container_name
  storage_account_name = data.terraform_remote_state.metastore.outputs.storage_account_name
  resource_group_name  = data.terraform_remote_state.metastore.outputs.unity_catalog_resource_group_name
}

module "storage_credential" {
  source = "./module/databricks_storage_credential"
  for_each = local.storage_definitions
  name                = each.value.storage_credential_name
  access_connector_id = data.terraform_remote_state.metastore.outputs.access_connector_id
  managed_identity_id = data.terraform_remote_state.metastore.outputs.user_assigned_identity_id

  providers = {
    databricks = databricks.workspace
  }
}

resource "null_resource" "metastore_assignment_dependency" {
  triggers = {
    metastore_assignment_id = data.terraform_remote_state.metastore.outputs.metastore_assignment.id
  }
}

module "external_location" {
  source  = "./module/databricks_external_location"
  for_each = local.storage_definitions
  name             = each.value.external_location_name
  url              = format("abfss://%s@%s.dfs.core.windows.net",
    module.storage_container[each.key].container_name,
    data.terraform_remote_state.metastore.outputs.storage_account_name
  )
  credential_name = module.storage_credential[each.key].storage_credential_id
  depends_on = [
    null_resource.metastore_assignment_dependency,
    module.storage_container,
    module.storage_credential
  ]

  providers = {
    databricks = databricks.workspace
  }
}

module "databricks_catalog_with_access" {
  source = "./module/databricks_catalog_with_access"
  for_each = local.enriched_catalog_definitions
  catalog_name   = each.key
  storage_root   = each.value.storage_root
  schema_names   = each.value.schema_names
  catalog_access = each.value.catalog_access
  #schema_access  = each.value.schema_access
  depends_on = [module.external_location]
  providers = {
    databricks = databricks.workspace
  }
}

module "databricks_catalog_schema_grants" {
  source        = "./module/databricks_catalog_schema_grants"
  for_each      = local.enriched_catalog_definitions
  catalog_name  = each.key
  schema_access = each.value.schema_access
  depends_on = [module.databricks_catalog_with_access[each.key]]
  providers = {
    databricks = databricks.workspace
  }
}

