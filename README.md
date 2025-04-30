# 📘 Terraform Databricks Deployment

## 🧱 Project Overview

This Terraform-based infrastructure-as-code project provisions and manages Azure Databricks resources across different modules and environments (e.g., `dev`, `prod`). It supports modular deployments, SCIM-based access control, secure credential handling, and automated Azure DevOps CI/CD pipelines.

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
│   │   ├── terraform.tfvars
│   │   └── variables.tf
│
│   ├── preprod/
│   │   ├── backend.tf
│   │   ├── data.tf
│   │   ├── locals.tf
│   │   ├── main.tf
│   │   ├── providers.tf
│   │   ├── terraform.tfvars
│   │   └── variables.tf
│
│   └── prod/
│       ├── backend.tf
│       ├── data.tf
│       ├── locals.tf
│       ├── main.tf
│       ├── providers.tf
│       ├── terraform.tfvars
│       └── variables.tf
│
├── modules/
│   ├── databricks_catalog_with_access/
│   ├── databricks_catalog_schema_grants/
│   ├── databricks_cluster/
│   ├── databricks_identity_access/
│   ├── external_location/
│   ├── sql_warehouse/
│   ├── storage_container/
│   └── storage_credential/
│
└── pipelines/
    ├── simegas-tf-adb-deploy-dev.yml
    ├── simegas-tf-adb-deploy-preprod.yml
    └── simegas-tf-adb-deploy-prod.yml
```

---

## 📦 Modules Used

| Module                          | Description                                                    |
|---------------------------------|----------------------------------------------------------------|
| `databricks_catalog_with_access` | Creates catalogs, schemas, and assigns access                  |
| `databricks_catalog_schema_grants` | Grants access to SCIM-synced Azure AD groups                |
| `databricks_cluster`            | Provisions Databricks clusters                                 |
| `databricks_identity_access`    | Queries Azure AD groups via SCIM                               |
| `external_location`             | Creates external locations pointing to mounted storage         |
| `sql_warehouse`                 | Creates SQL warehouses                                         |
| `storage_container`             | Provisions Azure Storage containers                            |
| `storage_credential`            | Creates Databricks storage credentials                         |

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

## 🔁 CI/CD Pipeline

One Azure DevOps YAML pipeline is used:

### 1. `simegas-tf-adb-deploy-env.yml`
- Initializes Terraform
- Fetches secrets from Azure Key Vault
- Runs `terraform plan`
- Handles dynamic firewall access to Key Vault
- Peer review, admin and platform owner approvals
- Executes `terraform apply` after plan validation
- Secured via service principal auth (OAuth M2M)
- Supports environment-specific deploys

---

## 🔐 Secrets & Auth

Secrets are stored in **Azure Key Vault** and accessed via environment variables:

- `DATABRICKS_ACCOUNT_CLIENT_ID`, `DATABRICKS_ACCOUNT_CLIENT_SECRET`
- `DATABRICKS_WORKSPACE_CLIENT_ID`, `DATABRICKS_WORKSPACE_CLIENT_SECRET`
- `DATABRICKS_WORKSPACE_HOST`
- `DATABRICKS_ACCOUNT_ID`
- `AccessKey-sasoldevterraform` (Azure Storage backend access key)

Firewall rules are dynamically updated for build agent IP access to Key Vault during runtime.

---

## 🧾 Abbreviations

| Acronym | Meaning                                |
|--------|----------------------------------------|
| ADB     | Azure Databricks                       |
| AKV     | Azure Key Vault                        |
| ENVS     | Environments|
| M2M     | Machine-to-Machine OAuth2 Flow         |
| SCIM    | System for Cross-domain Identity Mgmt. |
| SIMEGAS    |  |
| TF      | Terraform                     |





---

## ✅ Tips & Best Practices

- 🔁 Use a separate state file per environment.
- 🔐 Rotate secrets regularly in Azure Key Vault.
- 🛡️ Grant access via Azure AD groups using SCIM for least privilege.

## 📬 Contact & Contribution

For questions, updates, or to contribute:
- Contact: Platform Engineer (Mahlatse.Baholo@sasol.com), Platform Owner (Vusi.Sithole@sasol.com)
- PRs: Open a pull request against the `main` branch
- Bugs: Raise an issue in the tracker

---

