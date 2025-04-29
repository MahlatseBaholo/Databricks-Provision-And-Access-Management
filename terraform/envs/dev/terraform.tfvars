##############################################
# Define AD Groups and Permissions
##############################################
group_names = ["AES-DATAOPERATIONS"]


permission_assignments = {
  "AES-DATAOPERATIONS" = {
    principal_id = "AES-DATAOPERATIONS"  
    permissions  = ["USER"]             
  }
}

##############################################
# Define Entitlements for AD Groups
##############################################
entitlements = {
  "AES-DATAOPERATIONS" = {
    group_id              = "AES-DATAOPERATIONS"  
    workspace_access      = true                  
    databricks_sql_access = true                 
  }
}

##############################################
# Cluster Configuration and Updates
##############################################
cluster_name              = "delete-general-purpose"  
spark_version             = "15.4.x-scala2.12"       
node_type_id              = "Standard_DS3_v2"         
driver_node_type_id       = "Standard_DS3_v2"        
autotermination_minutes   = 10                       
enable_elastic_disk       = true                      
policy_id                 = "00186FF012D0AE5B"        
enable_local_disk_encryption = false                  
data_security_mode        = "USER_ISOLATION"          
runtime_engine            = "STANDARD"                 
apply_policy_default_values = false                  

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
  "AES-DATAOPERATIONS" = ["CAN_MANAGE"]     
}

##############################################
# Serverless SQL Warehouse Configuration
##############################################
sql_warehouse_name                     = "serverless-sql-warehouse-sandbox-small-delete" 
sql_warehouse_cluster_size             = "2X-Small"                                       
sql_warehouse_max_num_clusters         = 2                                            
sql_warehouse_min_num_clusters         = 1                                             
sql_warehouse_auto_stop_mins           = 5                                             
sql_warehouse_enable_serverless_compute = true                                         
sql_warehouse_enable_permissions       = true                                          

##############################################
# Serverless SQL Warehouse Permissions
##############################################
sql_warehouse_permissions = {   
  "AES-DATAOPERATIONS" = ["CAN_MANAGE"] 
}

##############################################
# Define and Manage Catalogs, Schemas, and Permissions
##############################################
catalog_definitions = {

  demo-dev = {
    project = "simegas"  
    schema_names = ["bronze", "silver", "gold"] 
    catalog_access = {
      "AES-DATAOPERATIONS" = [
        "APPLY_TAG", "BROWSE", "USE_CATALOG", "READ_VOLUME", "REFRESH", "EXECUTE", "SELECT", "USE_SCHEMA"
      ]
    }
    schema_access = {
      bronze = {
        "AES-DATAOPERATIONS" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      silver = {
        "AES-DATAOPERATIONS" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      gold = {
        "AES-DATAOPERATIONS" = [
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
      "AES-DATAOPERATIONS" = [
        "APPLY_TAG", "BROWSE", "USE_CATALOG", "READ_VOLUME", "REFRESH", "EXECUTE", "SELECT", "USE_SCHEMA"
      ]
    }
    schema_access = {
      bronze = {
        "AES-DATAOPERATIONS" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      silver = {
        "AES-DATAOPERATIONS" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      gold = {
        "AES-DATAOPERATIONS" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      }
    }
  }
}
