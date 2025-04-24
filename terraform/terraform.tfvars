storage_definitions = {
  test3 = {
    container_name            = "test3"
    storage_credential_name   = "sasoleuw-aes-dbsc-test3"
    external_location_name    = "test-catalog-external-location"
  },
  test4 = {
    container_name            = "test4"
    storage_credential_name   = "sasoleuw-aes-dbsc-test4"
    external_location_name    = "test4-catalog-external-location"
  }
}

catalog_definitions = {
  test_catalog = {
    storage_root = module.external_location["test3"].external_location_url
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
