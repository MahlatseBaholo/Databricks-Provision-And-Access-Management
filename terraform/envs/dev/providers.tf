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

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
}

provider "azurerm" {
  tenant_id       = "3d2c89c4-4762-4441-8185-505beedaf7af"
  subscription_id = "53b5fe7d-2477-4a93-943a-af5571bf146c"
  client_id       = "f8011808-8877-4385-917a-77b3f195e8e7"
  client_secret   = "3bqry2JZH7w/WjMre5CL7WDH/b6ig01iqlfTCehrxjY="
  features {}
  skip_provider_registration = true
}

provider "databricks" {
  alias         = "account"
  host          = "https://accounts.azuredatabricks.net"
  account_id    = var.account_id
  client_id     = var.account_client_id
  client_secret = var.account_client_secret
  auth_type     = "oauth-m2m"
}

provider "databricks" {
  alias         = "workspace"
  host          = var.workspace_host
  client_id     = var.workspace_client_id
  client_secret = var.workspace_client_secret
  auth_type     = "oauth-m2m"
}