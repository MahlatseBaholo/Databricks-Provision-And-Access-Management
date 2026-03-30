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