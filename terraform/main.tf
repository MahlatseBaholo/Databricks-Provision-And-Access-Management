# Define resource groups module
module "resource_groups" {
  source = "./modules/resource_groups"  # Path to the module directory
  region = var.region                   # Pass region variable to the resource_groups module
}

# Define storage module
module "storage" {
  source               = "./modules/storage"          # Path to the storage module
  resource_group_name  = module.resource_groups.name  # Pass the resource group name from resource_groups
  region               = var.region                   # Pass region variable
  storage_account_name = var.storage_account_name    # Pass storage account name
}
