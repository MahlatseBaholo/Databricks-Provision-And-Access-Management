##############################################
# Define AD Groups and Permissions
##############################################
group_names = ["AES-ADMIN", "AES-ADMIN"]

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

  ms_customer_b2b = {
    project = "aes2"  
    schema_names = ["bronze", "silver", "gold","ai"] 
    catalog_access = {
      "AES-ADMIN" = [
        "APPLY_TAG", "BROWSE", "USE_CATALOG", "READ_VOLUME", "REFRESH", "EXECUTE", "SELECT", "USE_SCHEMA"
      ],
      "AES-ADMIN" = [
        "ALL_PRIVILEGES"
      ]
    }
    schema_access = {
      bronze = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      silver = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      gold = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      ai = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ],
        "AES-ADMIN" = [
          "ALL_PRIVILEGES"
        ]
      }
    }
  }

  ms_customer_b2c = {
    project = "aes2"  
    schema_names = ["bronze", "silver", "gold","ai"] 
    catalog_access = {
      "AES-ADMIN" = [
        "APPLY_TAG", "BROWSE", "USE_CATALOG", "READ_VOLUME", "REFRESH", "EXECUTE", "SELECT", "USE_SCHEMA"
      ],
      "AES-ADMIN" = [
        "ALL_PRIVILEGES"
      ]
    }
    schema_access = {
      bronze = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      silver = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      gold = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      ai = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ],
        "AES-ADMIN" = [
          "ALL_PRIVILEGES"
        ]
      }
    }
  }

  ms_assets = {
    project = "aes2"  
    schema_names = ["bronze", "silver", "gold","ai"] 
    catalog_access = {
      "AES-ADMIN" = [
        "APPLY_TAG", "BROWSE", "USE_CATALOG", "READ_VOLUME", "REFRESH", "EXECUTE", "SELECT", "USE_SCHEMA"
      ],
      "AES-ADMIN" = [
        "ALL_PRIVILEGES"
      ]
    }
    schema_access = {
      bronze = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      silver = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      gold = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      ai = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ],
        "AES-ADMIN" = [
          "ALL_PRIVILEGES"
        ]
      }
    }
  }

  ms_products = {
    project = "aes2"  
    schema_names = ["bronze", "silver", "gold","ai"] 
    catalog_access = {
      "AES-ADMIN" = [
        "APPLY_TAG", "BROWSE", "USE_CATALOG", "READ_VOLUME", "REFRESH", "EXECUTE", "SELECT", "USE_SCHEMA"
      ],
      "AES-ADMIN" = [
        "ALL_PRIVILEGES"
      ]
    }
    schema_access = {
      bronze = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      silver = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      gold = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      ai = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ],
        "AES-ADMIN" = [
          "ALL_PRIVILEGES"
        ]
      }
    }
  }

  ms_employee = {
    project = "aes2"  
    schema_names = ["bronze", "silver", "gold","ai"] 
    catalog_access = {
      "AES-ADMIN" = [
        "APPLY_TAG", "BROWSE", "USE_CATALOG", "READ_VOLUME", "REFRESH", "EXECUTE", "SELECT", "USE_SCHEMA"
      ],
      "AES-ADMIN" = [
        "ALL_PRIVILEGES"
      ]
    }
    schema_access = {
      bronze = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      silver = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      gold = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      ai = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ],
        "AES-ADMIN" = [
          "ALL_PRIVILEGES"
        ]
      }
    }
  }

  ms_suppliers = {
    project = "aes2"  
    schema_names = ["bronze", "silver", "gold","ai"] 
    catalog_access = {
      "AES-ADMIN" = [
        "APPLY_TAG", "BROWSE", "USE_CATALOG", "READ_VOLUME", "REFRESH", "EXECUTE", "SELECT", "USE_SCHEMA"
      ],
      "AES-ADMIN" = [
        "ALL_PRIVILEGES"
      ]
    }
    schema_access = {
      bronze = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      silver = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      gold = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      ai = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ],
        "AES-ADMIN" = [
          "ALL_PRIVILEGES"
        ]
      }
    }
  }

  demo_tf = {
    project = "aes2"  
    schema_names = ["bronze", "silver", "gold","ai"] 
    catalog_access = {
      "AES-ADMIN" = [
        "APPLY_TAG", "BROWSE", "USE_CATALOG", "READ_VOLUME", "REFRESH", "EXECUTE", "SELECT", "USE_SCHEMA"
      ],
      "AES-ADMIN" = [
        "ALL_PRIVILEGES"
      ]
    }
    schema_access = {
      bronze = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      silver = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      gold = {
        "AES-ADMIN" = [
          "CREATE_FUNCTION", "CREATE_TABLE", "CREATE_MODEL", "CREATE_VOLUME", "CREATE_MATERIALIZED_VIEW",
          "USE_SCHEMA", "EXECUTE", "MODIFY", "SELECT", "READ_VOLUME", "REFRESH", "WRITE_VOLUME"
        ]
      },
      ai = {
        "AES-ADMIN" = [
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
folder_path = "/Workspace/dev/marketing-sales"

access_controls = [
  {
    group_name       = "AES-ADMIN"
    permission_level = "CAN_MANAGE"
  }
]
##############################################
# Cluster Configuration and Updates
##############################################
unit_definitions = {
  ms = {
    cluster = {
      spark_version           = "17.4.x-scala2.12"
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
        "AES-ADMIN" = ["CAN_ATTACH_TO"],
        "AES-ADMIN" = ["CAN_MANAGE"]       
      }
    }

    sql_warehouse = {
      enabled                   = true
      cluster_size              = "Small"
      max_num_clusters          = 2
      min_num_clusters          = 1
      auto_stop_mins            = 10
      enable_serverless_compute = true
      tags                      = { Unit = "ms" }
      warehouse_type            = "PRO"
      enable_permissions        = true

      permissions = {
        "AES-ADMIN" = ["CAN_USE"]
        "AES-ADMIN"                   = ["CAN_MANAGE"]
      }
    }
  }
}
