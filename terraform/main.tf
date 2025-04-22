module "workspace_rg" {
  source  = "./modules/resource_group"
  name    = var.resource_group_name_workspace
  location = var.location
}

module "catalog_rg" {
  source  = "./modules/resource_group"
  name    = var.resource_group_name_catalog
  location = var.location
}

module "databricks_workspace" {
  source              = "./modules/databricks_workspace"
  name                = var.workspace_name
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group_name_workspace.name
  sku                 = var.workspace_sku
}