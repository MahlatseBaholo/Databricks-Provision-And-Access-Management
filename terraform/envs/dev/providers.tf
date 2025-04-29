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


#provider "azurerm" {
#  features {}
#  skip_provider_registration = true

#  subscription_id = var.subscription_id
#  tenant_id       = var.tenant_id
#  client_id       = var.client_id
#  client_secret   = var.client_secret
#}

provider "azurerm" {
  tenant_id       = "3d2c89c4-4762-4441-8185-505beedaf7af"
  subscription_id = "53b5fe7d-2477-4a93-943a-af5571bf146c"
  client_id       = "f8011808-8877-4385-917a-77b3f195e8e7"
  client_secret   = "3bqry2JZH7w/WjMre5CL7WDH/b6ig01iqlfTCehrxjY="
  features {}
  skip_provider_registration = true
}

#provider "databricks" {
#  alias         = "account"
#  host          = "https://accounts.azuredatabricks.net"
#  account_id    = "16d23151-3113-4c3c-9cb0-bcfc27be30a1"
#  client_id     = "f457fcb6-eb37-4f7d-9859-058eb19f7741"
#  client_secret = "dose30b8050a8778e737a8545f89a41ee9ab"
#  auth_type     = "oauth-m2m"
#}

provider "databricks" {
  alias         = "workspace"
  host          = "https://adb-3787911233650262.2.azuredatabricks.net"
  client_id     = "085d9aab-a52c-4ef6-b983-4ff78908a68d"
  client_secret = "dosec6bee1d8b5f9ef1dd7bd9ccfba05ba42"
  auth_type     = "oauth-m2m"
}