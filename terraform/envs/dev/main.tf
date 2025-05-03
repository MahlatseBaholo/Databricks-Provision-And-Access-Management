resource "azurerm_resource_group" "sasolsan-simegas-dev-rg" {
  name     = "sasolsan-simegas-dev-rg"
  location = "southafricanorth" 
}

resource "azurerm_databricks_workspace" "sasol-dev-simegas-dbw" {
  name                = "sasol-dev-simegas-dbw"
  location            = azurerm_resource_group.sasolsan-simegas-dev-rg.location
  resource_group_name = azurerm_resource_group.sasolsan-simegas-dev-rg.name
  sku                 = "premium"
}

resource "azurerm_resource_group" "sasolsan-simegas-dev-terraform-rg" {
  name     = "sasolsan-simegas-dev-terraform-rg"
  location = "southafricanorth"
}

resource "azurerm_storage_account" "sasoldevsimegastf" {
  name                     = "sasoldevsimegastf"
  resource_group_name      = azurerm_resource_group.sasolsan-simegas-dev-terraform-rg.name
  location                 = azurerm_resource_group.sasolsan-simegas-dev-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "sasol-dev-simegas-dbw" {
  name                  = "metastoreazuresan"
  storage_account_name  = azurerm_storage_account.sasoldevsimegastf.name
  container_access_type = "private"
}

resource "databricks_metastore" "metastore_azure_southafricanorth" {
  provider      = databricks.account
  name          = "metastore_azure_southafricanorth"
  location      = azurerm_resource_group.sasolsan-simegas-unity-catalog-rg.location
}

resource "databricks_metastore_assignment" "metastore_azure_southafricanorth" {
  provider      = databricks.account
  metastore_id  = databricks_metastore.metastore_azure_southafricanorth.id
  workspace_id  = azurerm_databricks_workspace.sasol-dev-simegas-dbw.id
}

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

#resource "null_resource" "metastore_assignment_dependency" {
#  triggers = {
#    metastore_assignment_id = data.terraform_remote_state.metastoreazuresan.outputs.metastore_assignment.id
#  }
#}

module "external_location" {
  source = "../../modules/databricks_external_location"
  for_each = local.storage_definitions

  name             = each.value.external_location_name
  url              = format("abfss://%s@%s.dfs.core.windows.net",
    module.storage_container[each.key].container_name,
    data.terraform_remote_state.metastoreazuresan.outputs.storage_account_name
  )
  credential_name = module.storage_credential[each.key].storage_credential_id
  providers = {
    databricks = databricks.workspace
  }
  depends_on = [
    #null_resource.metastore_assignment_dependency,
    databricks_metastore_assignment,
    module.storage_container,
    module.storage_credential
  ]
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