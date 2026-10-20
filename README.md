# 📘 Terraform Databricks Deployment

## 🧱 Project Overview

This Terraform-based infrastructure-as-code project provisions and manages Azure Databricks resources across different modules and environments (e.g., `dev`,`qa`, `prod`). It supports modular deployments, SCIM-based access control, secure credential handling, and automated Azure DevOps CI/CD pipelines.

## 🧾 Abbreviations

| Acronym | Meaning                                                                           |
|---------|------------------------------------------------------------------------------------|
| ADB     | Azure Databricks                                                                  |
| DBW     | Databricks Workspace                                                              |
| AKV     | Azure Key Vault                                                                   |
| ENVS    | Environments (dev,qa,prod)                                                       |
| M2M     | Machine-to-Machine OAuth2 Flow                                                    |
| SCIM    | System for Cross-domain Identity Mgmt.                                            |
| SIMEGAS | Sasol Information Management Enterprise Generative Artificial Intelligence System |
| TF      | Terraform                                                                         |

---

## 📂 Project Structure

```
terraform/
├── envs/
│   ├── dev/
│   │   ├── backend.tf
│   │   ├── data.tf
│   │   ├── locals.tf
│   │   ├── main.tf
│   │   ├── providers.tf
│   │   ├── simegas-tf-adb-deploy-dev.yml
│   │   ├── terraform.tfvars
│   │   └── variables.tf
│   ├── prod/
│   │   ├── backend.tf
│   │   ├── data.tf
│   │   ├── locals.tf
│   │   ├── main.tf
│   │   ├── providers.tf
│   │   ├── simegas-tf-adb-deploy-prod.yml
│   │   ├── terraform.tfvars
│   │   └── variables.tf
│   └── qa/
│       ├── backend.tf
│       ├── data.tf
│       ├── locals.tf
│       ├── main.tf
│       ├── providers.tf
│       ├── simegas-tf-adb-deploy-qa.yml
│       ├── terraform.tfvars
│       └── variables.tf
│
└── modules/
   ├── databricks_budget/
   ├── databricks_catalog_schema_grants/
   ├── databricks_catalog_with_access/
   ├── databricks_cluster_with_permissions/
   ├── external_location/
   ├── databricks_folder_usage_permissions/
   ├── databricks_identity_access/  
   ├── databricks_sql_warehouse/
   ├── databricks_storage_credential/
   └── storage_container/
```

---

## 📦 Modules Used

| Module                          | Description                                                    |
|---------------------------------|----------------------------------------------------------------|
| `databricks_budget` | Creates budgets and send notifications to workspace owner                  |
| `databricks_catalog_schema_grants` | Grants access to SCIM-synced Azure AD groups                |
| `databricks_catalog_with_access` | Creates catalogs, schemas, and assigns access                  |
| `databricks_cluster_with_permissions`            | Provisions Databricks clusters                                 |
| `databricks_external_location`             | Creates external locations pointing to mounted storage         |
| `databricks_folder_usage_permissions` | Grants access to folders                |
| `databricks_identity_access`    | Queries Azure AD groups via SCIM                               |
| `databricks_sql_warehouse`                 | Creates SQL warehouses                                         |
| `databricks_storage_credential` | Creates Databricks storage credentials                         |
| `storage_container`            |Provisions Azure Storage containers                          |

---

## 🔧 Core Terraform Files (per environment)

| File               | Purpose                                                              |
|--------------------|----------------------------------------------------------------------|
| `backend.tf`        | Defines remote backend in Azure Storage for state management         |
| `data.tf`           | Fetches remote state and AD groups                                   |
| `locals.tf`         | Defines reusable local variables (e.g., naming conventions)          |
| `main.tf`           | Calls and wires all modules                                          |
| `providers.tf`      | Configures `azurerm` and `databricks` providers                      |
| `terraform.tfvars`  | Supplies variable values for current environment                     |
| `variables.tf`      | Declares variables expected from tfvars or pipeline                  |

---

## 🔁 CI/CD Pipeline and Trigger

One Azure DevOps YAML pipeline is used per environment:

### 1. `simegas-tf-adb-deploy-env.yml`
- Initializes Terraform
- Fetches secrets from Azure Key Vault
- Runs `terraform plan`
- Handles dynamic firewall access to Key Vault
- Peer review, admin and platform owner approvals
- Executes `terraform apply` after plan validation
- Secured via service principal auth (OAuth M2M)
- Supports environment-specific deploys

Pipelines are automatically triggered till the plan stage, apply stage will only execute post plan review and approval.

| Pipeline                   | Dependency                |
|----------------------------|---------------------------|
| simegas-tf-adb-deploy-dev  | Main branch               |
| simegas-tf-adb-deploy-qa   | simegas-tf-adb-deploy-dev |
| simegas-tf-adb-deploy-prod | simegas-tf-adb-deploy-qa  |

---

## 🔥 Databricks Managed Workspaces

| Workspace              | Link                                                                    |
|------------------------|-------------------------------------------------------------------------|
| sasol-dev-simegas-dbw  | https://adb-1584894596117397.17.azuredatabricks.net/?o=1584894596117397 |
| sasol-qa-simegas-dbw   | https://adb-1803701311157133.13.azuredatabricks.net/?o=1803701311157133 |
| sasol-prod-simegas-dbw | https://adb-1910321470216143.3.azuredatabricks.net/?o=1910321470216143  |

---
## 🔐 Secrets & Auth

Secrets are stored in **Azure Key Vault** and accessed via environment variables:

- `DATABRICKS_ACCOUNT_CLIENT_ID`, `DATABRICKS_ACCOUNT_CLIENT_SECRET`
- `DATABRICKS_WORKSPACE_CLIENT_ID`, `DATABRICKS_WORKSPACE_CLIENT_SECRET`
- `DATABRICKS_WORKSPACE_HOST`
- `DATABRICKS_ACCOUNT_ID`
- `AccessKey-sasol$(env)terraform` (Azure Storage backend access key)

Firewall rules are dynamically updated for build agent IP access to Key Vault during runtime.

---
## 🛠️ Troubleshooting
 
| Error | Source |Fix                                |
|--------|-------|----------------------------------------|
| "PERMINSSION DENIED: User name.surname@sasol.com does not have READ permission on scope KeyVault to perform this action |Databricks Notebook | Log a request on the service catalog here:https://myim.service-now.com/sp?id=sc_cat_item&sys_id=c0768b14c3d69a9039011ef0e00131f9                     |
| Error: Error acquiring the state lock     | Pipeline Build Results  | Please contact Platform Engineer to break lease on blob                     |
## 📬 Contact & Contribution

For questions, updates, or to contribute:
- Contact: Platform Engineer (Mahlatse.Baholo@sasol.com), Platform Owner (Vusi.Sithole@sasol.com)
- PRs: Open a pull request against the `main` branch and forward to Platform Engineer for approval

---