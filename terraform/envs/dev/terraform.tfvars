##############################################
# Define AD Groups and Permissions
##############################################
group_names = ["SIMEGAS-ADMIN", "GenAI-Developers"]

permission_assignments = {
  "GenAI-Developers" = {
    principal_id = "GenAI-Developers"  
    permissions  = ["USER"]             
  },
    "SIMEGAS-ADMIN" = {
    principal_id = "SIMEGAS-ADMIN"  
    permissions  = ["ADMIN"]             
  }
}

##############################################
# Define Entitlements for AD Groups
##############################################
entitlements = {
  "GenAI-Developers" = {
    group_id              = "GenAI-Developers"  
    workspace_access      = true                  
    databricks_sql_access = true                 
  },
  "SIMEGAS-ADMIN" = {
    group_id              = "SIMEGAS-ADMIN"  
    workspace_access      = true                  
    databricks_sql_access = true                 
  }
}

##############################################
# Define and Manage Catalogs, Schemas, and Permissions
##############################################
catalog_definitions = {

  ai = {
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
  test = {
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
cluster_name              = "multi-node-simegas-small-general-purpose"  
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
  "GenAI-Developers" = ["CAN_ATTACH_TO"],
  "SIMEGAS-ADMIN" = ["CAN_ATTACH_TO"]       
}

##############################################
# Serverless SQL Warehouse Configuration
##############################################
sql_warehouse_name                      = "serverless-sql-warehouse-simegas-small" 
sql_warehouse_cluster_size              = "2X-Small"                                       
sql_warehouse_max_num_clusters          = 2                                            
sql_warehouse_min_num_clusters          = 1                                             
sql_warehouse_auto_stop_mins            = 10                                             
sql_warehouse_enable_serverless_compute = false                                         
sql_warehouse_enable_permissions        = true
warehouse_type                          = "PRO"                                          

##############################################
# Serverless SQL Warehouse Permissions
##############################################
sql_warehouse_permissions = {   
  "GenAI-Developers" = ["CAN_USE"],
  "SIMEGAS-ADMIN" = ["CAN_USE"]  
}