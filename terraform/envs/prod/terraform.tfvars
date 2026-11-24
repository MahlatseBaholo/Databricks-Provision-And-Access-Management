##############################################
# Define AD Groups and Permissions
##############################################
group_names = ["AES-ADMIN"]

permission_assignments = {
  "AES-ADMIN" = {
    principal_id = "AES-ADMIN"  
    permissions  = ["USER"]             
  },
    "AES-ADMIN" = {
    principal_id = "AES-ADMIN"  
    permissions  = ["ADMIN"]             
  }
}

##############################################
# Define Entitlements for AD Groups
##############################################
entitlements = {
  "AES-ADMIN" = {
    group_id              = "AES-ADMIN"  
    workspace_access      = true
    databricks_sql_access = false                                   
  }
}

##############################################
# Define and Manage Catalogs, Schemas, and Permissions
##############################################
catalog_definitions = {
  aes_pm = {
    project = "plantmaintenance"  
    schema_names = ["bronze", "silver", "gold"]

    storage_account_name    = "sasoldevaeslake"
    storage_container_name  = "eop-so"
    storage_folder          = "plantmaintenance"

    schema_paths = {
      bronze = "bronze"
      silver = "silver"
      gold   = "gold"
    }

    comment = "This catalog is for plant maintance, please contact Gedion Botha for any enquiries" 
    catalog_access = {
      "AES-EOP_SO-DATAENGINEERING" = [
        "APPLY_TAG", "BROWSE", "USE_CATALOG", "READ_VOLUME", "REFRESH", "EXECUTE", "SELECT", "USE_SCHEMA"
      ]
      #,
      #"AES-ADMIN" = [
      #  "ALL_PRIVILEGES"
      #]
    }
    schema_access = {
      bronze = {
        "AES-EOP_SO-DATAENGINEERING" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      silver = {
        "AES-EOP_SO-DATAENGINEERING" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      gold = {
        "AES-EOP_SO-DATAENGINEERING" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      }
    }
  }
}

##############################################
# Cluster Configuration and Updates
##############################################
unit_definitions = {
    dpms = {
    sql_warehouse = {
      enabled                   = false
      cluster_size              = "Small"
      max_num_clusters          = 2
      min_num_clusters          = 1
      auto_stop_mins            = 10
      enable_serverless_compute = true
      tags                      = { Unit = "risk_she" }
      warehouse_type            = "PRO"
      enable_permissions        = true

      permissions = {
        "AES-EOP_SHE-DATAENGINEERING" = ["CAN_USE"]
      }
    }
  }
}
##############################################
# Define Folder Usage Permissions
##############################################
folder_path = "/Workspace"

access_controls = [
  {
    group_name       = "users"
    permission_level = "CAN_READ"
  }
]