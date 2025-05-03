#module "databricks_budgets" {
#  source = "../../modules/databricks_budget"
#  providers = {
#    databricks.account = databricks.account
#    databricks.workspace = databricks.workspace
    #databricks = databricks.account
#  }

#  budgets = var.budgets
#}

module "databricks_identity_access" {
  source = "../../modules/databricks_identity_access"
  
  permission_assignments = var.permission_assignments
  entitlements           = var.entitlements
  group_names            = var.group_names
  providers = {
    databricks.account   = databricks.account
    databricks.workspace = databricks.workspace
  }
}

module "storage_container" {
  source = "../../modules/storage_container"
  for_each = local.storage_definitions
  name                 = each.value.container_name
  storage_account_name = data.terraform_remote_state.metastoreazuresan.outputs.storage_account_name
  resource_group_name  = data.terraform_remote_state.metastoreazuresan.outputs.unity_catalog_resource_group_name
}

module "storage_credential" {
  source = "../../modules/databricks_storage_credential"
  for_each = local.storage_definitions
  name                = each.value.storage_credential_name
  access_connector_id = data.terraform_remote_state.metastoreazuresan.outputs.access_connector_id
  managed_identity_id = data.terraform_remote_state.metastoreazuresan.outputs.user_assigned_identity_id
  providers = {
    databricks = databricks.workspace
  }
}

resource "null_resource" "metastore_assignment_dependency" {
  triggers = {
    metastore_assignment_id = data.terraform_remote_state.metastoreazuresan.outputs.metastore_assignment.id
  }
}

module "external_location" {
  source  = "../../modules/databricks_external_location"
  for_each = local.storage_definitions
  name             = each.value.external_location_name
  url              = format("abfss://%s@%s.dfs.core.windows.net",
    module.storage_container[each.key].container_name,
    data.terraform_remote_state.metastoreazuresan.outputs.storage_account_name
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
  source = "../../modules/databricks_catalog_with_access"
  for_each = local.enriched_catalog_definitions
  catalog_name   = each.key
  storage_root   = each.value.storage_root
  schema_names   = each.value.schema_names
  catalog_access = each.value.catalog_access
  depends_on = [module.external_location]
  providers = {
    databricks = databricks.workspace
  }
}

module "databricks_catalog_schema_grants" {
  source = "../../modules/databricks_catalog_schema_grants"
  for_each = local.enriched_catalog_definitions
  catalog_name  = each.key
  schema_names  = each.value.schema_names
  schema_access = each.value.schema_access
  depends_on = [module.databricks_catalog_with_access]
  providers = {
    databricks = databricks.workspace
  }
}

module "folder_permissions" {
  source = "../../modules/databricks_folder_usage_permissions"

  directory_path  = var.folder_path
  access_controls = var.access_controls

  providers = {
    databricks = databricks.workspace
  }
}
