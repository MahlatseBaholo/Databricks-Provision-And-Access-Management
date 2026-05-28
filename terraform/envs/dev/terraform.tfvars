##############################################
# Unit name
##############################################
units = ["ms", "finance"]

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
env = "dev"

unit_definitions = {
  ms = {
    clusters = {
      small = {
        autoscale = { min_workers = 2, max_workers = 10 }
      }
      medium = {
        node_type_id        = "Standard_D8ds_v5"
        driver_node_type_id = "Standard_D8ds_v5"
        autoscale           = { min_workers = 4, max_workers = 20 }
        autotermination_minutes = 20
      }
    }

    sql_warehouse = {
      name_suffix      = "serverless-sql-warehouse-aes2-small"
      cluster_size     = "2X-Small"
      max_num_clusters = 2
      min_num_clusters = 1
      auto_stop_mins   = 10
      warehouse_type   = "Serverless"
    }
  }

  finance = {
    clusters = {
      small = {
        spark_version = "15.4.x-scala2.12"
        autoscale     = { min_workers = 1, max_workers = 6 }
      }
      large = {
        node_type_id        = "Standard_E8ds_v5"
        driver_node_type_id = "Standard_E8ds_v5"
        autoscale           = { min_workers = 8, max_workers = 40 }
      }
    }
  }
}



##############################################
# Cluster Permissions for AD Groups
##############################################
cluster_permissions = {
  "AES-EBU_MOBI-DATAENGINEERING" = ["CAN_ATTACH_TO","CAN_RESTART"],
  "AES-ADMIN" = ["CAN_ATTACH_TO"]       
}
                                          
##############################################
# Serverless SQL Warehouse Permissions
##############################################
sql_warehouse_permissions = {   
  "AES-EBU_MOBI-DATAENGINEERING" = ["CAN_USE"],
  "AES-ADMIN" = ["CAN_USE"]  
}