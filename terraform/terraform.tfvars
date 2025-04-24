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
