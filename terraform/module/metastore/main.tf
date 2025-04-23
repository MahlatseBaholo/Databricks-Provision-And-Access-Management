terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
      configuration_aliases = [databricks.azure_account]
    }
  }
}

resource "databricks_metastore" "metastore" {
  metastore_id = var.metastore_id
}
