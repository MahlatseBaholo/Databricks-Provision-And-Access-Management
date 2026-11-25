##############################################
# Define AD Groups and Permissions
##############################################
group_names = ["AES-ADMIN", "AES-DATAOPERATIONS", "AES-EOP_SHE-DATAENGINEERING", "AES-EOP_SO-DATAENGINEERING"]

permission_assignments = {
  "AES-ADMIN" = {
    principal_id = "AES-ADMIN"  
    permissions  = ["ADMIN"]             
  },
    "AES-DATAOPERATIONS" = {
    principal_id = "AES-DATAOPERATIONS"  
    permissions  = ["ADMIN"]             
  },
  "AES-EOP_SHE-DATAENGINEERING" = {
    principal_id = "AES-EOP_SHE-DATAENGINEERING"  
    permissions  = ["USER"]             
  },
  "AES-EOP_SO-DATAENGINEERING" = {
    principal_id = "AES-EOP_SO-DATAENGINEERING"  
    permissions  = ["USER"]             
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
  },
  "AES-DATAOPERATIONS" = {
    group_id              = "AES-DATAOPERATIONS"  
    workspace_access      = true                  
    databricks_sql_access = false                 
  },
  "AES-EOP_SHE-DATAENGINEERING" = {
    group_id              = "AES-EOP_SHE-DATAENGINEERING"  
    workspace_access      = true                  
    databricks_sql_access = false                 
  },
  "AES-EOP_SO-DATAENGINEERING" = {
    group_id              = "AES-EOP_SO-DATAENGINEERING"  
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

    storage_account_name    = "sasolprodaeslake"
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
        "BROWSE", "USE_CATALOG", "READ_VOLUME", "SELECT", "USE_SCHEMA"
      ]
      #,
      #"AES-ADMIN" = [
      #  "ALL_PRIVILEGES"
      #]
    }
    schema_access = {
      bronze = {
        "AES-EOP_SO-DATAENGINEERING" = [
          "USE_SCHEMA", "SELECT", "READ_VOLUME"
        ]
      },
      silver = {
        "AES-EOP_SO-DATAENGINEERING" = [
          "USE_SCHEMA", "SELECT", "READ_VOLUME"
        ]
      },
      gold = {
        "AES-EOP_SO-DATAENGINEERING" = [
          "USE_SCHEMA", "SELECT", "READ_VOLUME"
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
    cluster = {
      spark_version           = "17.3.x-scala2.13"
      node_type_id            = "Standard_DS3_v2"
      driver_node_type_id     = "Standard_DS3_v2"
      autotermination_minutes = 10
      data_security_mode      = "USER_ISOLATION"
      azure_attributes = {
        first_on_demand    = 1
        availability       = "SPOT_WITH_FALLBACK_AZURE"
        spot_bid_max_price = -1
      }
      autoscale = { min_workers = 2, max_workers = 10 }
      cluster_permissions = { 
        "AES-ADMIN" = ["CAN_RESTART"]      
      }
    }

    sql_warehouse = {
      enabled                   = true
      cluster_size              = "Small"
      max_num_clusters          = 2
      min_num_clusters          = 1
      auto_stop_mins            = 10
      enable_serverless_compute = true
      tags                      = { Unit = "dpms" }
      warehouse_type            = "PRO"
      enable_permissions        = true

      permissions = {
        "AES-ADMIN" = ["CAN_USE"]
      }
    }
  }
}
##############################################
# Define Folder Usage Permissions
##############################################
folder_paths = [
  "Workspace","/Workspace/preprod/plantmaintenance"
]

access_controls = [
  {
    group_name       = "AES-EOP_SO-DATAENGINEERING"
    permission_level = "CAN_READ"
  }
]