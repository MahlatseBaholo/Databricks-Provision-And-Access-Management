module "databricks_budgets" {
  source = "../../modules/databricks_budget"
  providers = {
    databricks.account = databricks.account
    #databricks.workspace = databricks.workspace
    #databricks = databricks.account
  }
  budgets = var.budgets
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

resource "null_resource" "metastore_assignment_dependency" {
  triggers = {
    metastore_assignment_id = data.terraform_remote_state.databricks-metastore-assignment.outputs.metastore_assignment.id
  }
}

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
    null_resource.metastore_assignment_dependency,
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

module "databricks_cluster" {
  source = "../../modules/databricks_cluster_with_permissions"

  cluster_name                 = var.cluster_name
  spark_version                = var.spark_version
  node_type_id                 = var.node_type_id
  driver_node_type_id          = var.driver_node_type_id
  autotermination_minutes      = var.autotermination_minutes
  azure_attributes             = var.azure_attributes
  autoscale                    = var.autoscale
  data_security_mode           = var.data_security_mode
  cluster_permissions          = var.cluster_permissions
  depends_on = [module.databricks_catalog_schema_grants]
  providers = {
    databricks = databricks.workspace
  }
}

module "sql_warehouse" {
  source                     = "../../modules/databricks_sql_warehouse"
  name                       = var.sql_warehouse_name
  cluster_size               = var.sql_warehouse_cluster_size
  max_num_clusters           = var.sql_warehouse_max_num_clusters
  min_num_clusters           = var.sql_warehouse_min_num_clusters
  auto_stop_mins             = var.sql_warehouse_auto_stop_mins
  enable_serverless_compute  = var.sql_warehouse_enable_serverless_compute
  tags                       = var.sql_warehouse_tags
  warehouse_type             = var.warehouse_type

  enable_permissions         = var.sql_warehouse_enable_permissions
  permissions                = var.sql_warehouse_permissions
  depends_on = [module.databricks_cluster]
  providers = {
    databricks = databricks.workspace
  }
}
