storage_definitions = {
  test1 = {
    container_name            = "test1"
    storage_credential_name   = "sasoleuw-aes-dbsc-test1"
    external_location_name    = "test-catalog-external-location"
  }
  test2 = {
    container_name            = "test2"
    storage_credential_name   = "sasoleuw-aes-dbsc-test2"
    external_location_name    = "test2-catalog-external-location"
  }
}

access_config_file                      = "access.yaml"

catalog_name = "test_catalog"
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

