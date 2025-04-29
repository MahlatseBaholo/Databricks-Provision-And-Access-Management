group_names = ["AES-DATAOPERATIONS"]

permission_assignments = {
  "AES-DATAOPERATIONS" = {
    principal_id = "AES-DATAOPERATIONS" 
    permissions  = ["USER"]
  }
}

entitlements = {
  "AES-DATAOPERATIONS" = {
    group_id              = "AES-DATAOPERATIONS"
    workspace_access      = true
    databricks_sql_access = true
  }
}

cluster_name            = "delete-general-purpose"
spark_version           = "15.4.x-scala2.12"
node_type_id            = "Standard_DS3_v2"
driver_node_type_id     = "Standard_DS3_v2"
autotermination_minutes = 10
enable_elastic_disk     = true
policy_id               = "00186FF012D0AE5B"
enable_local_disk_encryption = false
data_security_mode      = "USER_ISOLATION"
runtime_engine          = "STANDARD"
apply_policy_default_values = false

azure_attributes = {
  first_on_demand    = 1
  availability       = "SPOT_WITH_FALLBACK_AZURE"
  spot_bid_max_price = -1
}

autoscale = {
  min_workers = 2
  max_workers = 10
}

cluster_permissions = {
  "users"  = ["CAN_ATTACH_TO", "CAN_RESTART"]
  "admins" = ["CAN_MANAGE"]
}

catalog_definitions = {
  demo-dev = {
    project = "simegas"
    schema_names = ["bronze", "silver", "gold"]
    catalog_access = {
      "GenAI-Developers" = [
        "APPLY_TAG", "BROWSE", "USE_CATALOG", "READ_VOLUME", "REFRESH", "EXECUTE", "SELECT", "USE_SCHEMA"
      ]
    }
    schema_access = {
      bronze = {
        "GenAI-Developers" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      silver = {
        "GenAI-Developers" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      gold = {
        "GenAI-Developers" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      }
    }
  },
  demo2-dev = {
    project = "aes"
    schema_names = ["bronze", "silver", "gold"]
    catalog_access = {
      "GenAI-Developers" = [
        "APPLY_TAG", "BROWSE", "USE_CATALOG", "READ_VOLUME", "REFRESH", "EXECUTE", "SELECT", "USE_SCHEMA"
      ]
    }
    schema_access = {
      bronze = {
        "GenAI-Developers" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      silver = {
        "GenAI-Developers" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      gold = {
        "GenAI-Developers" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      }
    }
  }
}