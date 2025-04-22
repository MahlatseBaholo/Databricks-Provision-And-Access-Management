provider "databricks" {
  host                        = "https://<your-databricks-instance>"
  azure_workspace_resource_id = "<your-workspace-resource-id>"
}

locals {
  metastore_id   = "<your-metastore-id>"
  access_config  = yamldecode(file("${path.module}/access.yaml"))
}

module "metastore_assignment" {
  source  = "data-platform-hq/metastore-assignment/databricks"
  version = "~> 1.0.0"

  workspace_id = "<your-workspace-id>"
  metastore_id = local.metastore_id

  providers = {
    databricks = databricks
  }
}

module "unity_catalog" {
  source  = "data-platform-hq/unity-catalog/databricks"
  version = "~> 1.1.0"

  env              = "production"
  metastore_id     = local.metastore_id
  metastore_grants = [
    {
      principal  = "admin@databricks.com"
      privileges = ["CREATE_CATALOG", "CREATE_EXTERNAL_LOCATION"]
    },
    {
      principal  = "governance@databricks.com"
      privileges = ["CREATE_SHARE", "CREATE_RECIPIENT", "CREATE_PROVIDER"]
    }
  ]

  catalog = local.access_config

  depends_on = [module.metastore_assignment]

  providers = {
    databricks = databricks
  }
}