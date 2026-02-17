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
  auth_type     = "oauth-m2m"
}

provider "databricks" {
  alias         = "workspace"
  auth_type     = "oauth-m2m"
}