terraform {
  backend "azurerm" {
    resource_group_name  = "sasoleuw-big-data-aes-restore-rg"
    storage_account_name = "sasolaesiac"
    container_name       = "terraform"
    key                  = "adb-unity-catalog-sandbox.tfstate"
    access_key           = "rL8c4EJ0WhHyKlMhr96th9swepgB56xB47O5Eo3XYLHzywn0bfpRqTjvKG8yY+vr0dpaf0HL3h6O+AStFcZE6w=="
  }

}