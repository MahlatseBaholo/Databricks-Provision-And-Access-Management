##############################################
# Define AD Groups and Permissions
##############################################
group_names = ["AES-ADMIN", "AES-EBU_MOBI-DATAENGINEERING"]

permission_assignments = {
  "AES-EBU_MOBI-DATAENGINEERING" = {
    principal_id = "AES-EBU_MOBI-DATAENGINEERING"  
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
  "AES-EBU_MOBI-DATAENGINEERING" = {
    group_id              = "AES-EBU_MOBI-DATAENGINEERING"  
    workspace_access      = true                  
    databricks_sql_access = true                 
  },
  "AES-ADMIN" = {
    group_id              = "AES-ADMIN"  
    workspace_access      = true                  
    databricks_sql_access = true                 
  }
}

##############################################
# Define and Manage Catalogs, Schemas, and Permissions
##############################################
catalog_definitions = {

  ms-customer-b2b = {
    project = "aes2"  
    schema_names = ["bronze", "silver", "gold","ai"] 
    catalog_access = {
      "AES-EBU_MOBI-DATAENGINEERING" = [
        "APPLY_TAG", "BROWSE", "USE_CATALOG", "READ_VOLUME", "REFRESH", "EXECUTE", "SELECT", "USE_SCHEMA"
      ],
      "AES-ADMIN" = [
        "ALL_PRIVILEGES"
      ]
    }
    schema_access = {
      bronze = {
        "AES-EBU_MOBI-DATAENGINEERING" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      silver = {
        "AES-EBU_MOBI-DATAENGINEERING" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      gold = {
        "AES-EBU_MOBI-DATAENGINEERING" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      ai = {
        "AES-EBU_MOBI-DATAENGINEERING" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ],
        "AES-ADMIN" = [
          "ALL_PRIVILEGES"
        ]
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
  },
  {
    group_name       = "users"
    permission_level = "CAN_RUN"
  },
  {
    group_name       = "users"
    permission_level = "CAN_EDIT"
  },
  {
    group_name       = "users"
    permission_level = "CAN_MANAGE"
  }
]
 
##############################################
# Cluster Configuration and Updates
##############################################
cluster_name              = "ms-multi-node-aes2-small-general-purpose"  
spark_version             = "15.4.x-scala2.12"       
node_type_id              = "Standard_DS3_v2"         
driver_node_type_id       = "Standard_DS3_v2"        
autotermination_minutes   = 10                                                                         
data_security_mode        = "USER_ISOLATION"

azure_attributes = {
  first_on_demand        = 1                             
  availability           = "SPOT_WITH_FALLBACK_AZURE"  
  spot_bid_max_price     = -1                           
}

autoscale = {
  min_workers = 2   
  max_workers = 10  
}

##############################################
# Cluster Permissions for AD Groups
##############################################
cluster_permissions = {
  "AES-EBU_MOBI-DATAENGINEERING" = ["CAN_ATTACH_TO","CAN_RESTART"],
  "AES-ADMIN" = ["CAN_ATTACH_TO"]       
}

##############################################
# Pro SQL Warehouse Configuration
##############################################
sql_warehouse_name                      = "ms-serverless-sql-warehouse-aes2-small" 
sql_warehouse_cluster_size              = "2X-Small"                                       
sql_warehouse_max_num_clusters          = 2                                            
sql_warehouse_min_num_clusters          = 1                                             
sql_warehouse_auto_stop_mins            = 10                                             
sql_warehouse_enable_serverless_compute = false                                         
sql_warehouse_enable_permissions        = true
warehouse_type                          = "Serverless"                                           

##############################################
# Pro SQL Warehouse Permissions
##############################################
sql_warehouse_permissions = {   
  "AES-EBU_MOBI-DATAENGINEERING" = ["CAN_USE"],
  "AES-ADMIN" = ["CAN_USE"]  
}