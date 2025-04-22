# Resource Groups
module "resource_groups" {
  source = "./modules/resource_groups"
  region = var.region
}

# Databricks Workspace
module "workspace" {
  source              = "./modules/databricks_workspace"
  region              = var.region
  rg_name             = module.resource_groups.dev_rg_name
  workspace_name      = var.workspace_name
}

# Storage Account & Container
module "storage" {
  source             = "./modules/storage"
  rg_name            = module.resource_groups.catalog_rg_name
  region             = var.region
  storage_account    = var.storage_account
  container_name     = var.container_name
}

# Managed Identity
module "identity" {
  source  = "./modules/identity"
  rg_name = module.resource_groups.catalog_rg_name
  region  = var.region
  name    = var.identity_name
}

# Access Connector
module "access_connector" {
  source  = "./modules/access_connector"
  rg_name = module.resource_groups.catalog_rg_name
  region  = var.region
  name    = var.access_connector_name
  identity_id = module.identity.identity_id
}

# Storage Credential
module "storage_credential" {
  source              = "./modules/storage_credential"
  name                = var.credential_name
  comment             = "Storage credential for Unity Catalog external locations"
  access_connector_id = module.access_connector.access_connector_id
  managed_identity_id = module.identity.identity_id
}

# External Location
module "external_location" {
  source          = "./modules/external_location"
  name            = var.external_location_name
  url             = "abfss://${var.container_name}@${var.storage_account}.dfs.core.windows.net"
  credential_name = module.storage_credential.this.name
  comment         = "External location for Unity Catalog"
  depends_on      = [module.storage_credential]
}

# Optionally add Unity Catalog grant modules here as required
module "catalogs" {
  source  = "data-platform-hq/unity-catalog/databricks"
  version = "~> 1.1.0"
  env              = var.env
  metastore_id     = var.metastore_id
  catalog          = yamldecode(file("${path.module}/access.yaml"))
  providers = {
    databricks = databricks.workspace
  }
}
