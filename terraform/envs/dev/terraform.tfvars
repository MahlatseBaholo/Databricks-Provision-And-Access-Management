permission_assignments = {
  "GenAI-Developers" = {
    principal_id = GenAI-Developers
    permissions  = ["USER"]
  }
}

entitlements = {
  "GenAI-Developers" = {
    group_id              = GenAI-Developers
    workspace_access      = true
    databricks_sql_access = true
  }
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