terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>3.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "~>1.5"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

provider "databricks" {
  alias         = "azure_account"
  host          = "https://accounts.azuredatabricks.net"
  account_id    = "16d23151-3113-4c3c-9cb0-bcfc27be30a1"
  client_id     = "f457fcb6-eb37-4f7d-9859-058eb19f7741"
  client_secret = "dose30b8050a8778e737a8545f89a41ee9ab"
  auth_type     = "oauth-m2m"
}

provider "databricks" {
  alias         = "workspace"
  host          = ""
  client_id     = ""
  client_secret = ""
  auth_type     = "oauth-m2m"
}

provider "databricks" {
  alias         = "account"
  host          = "https://accounts.azuredatabricks.net"
  account_id    = "16d23151-3113-4c3c-9cb0-bcfc27be30a1"
  client_id     = "bfbaa02d-d71d-4c5a-a818-8841e11055f1"
  client_secret = "doseafd9cf30d293db31903c7638192ec3c7"
  auth_type     = "oauth-m2m"
}