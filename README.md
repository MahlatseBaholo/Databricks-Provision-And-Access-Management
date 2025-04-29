# 🌐 Terraform Deployment for Databricks Platform on Azure

This repository automates the deployment and configuration of a secure, scalable Databricks environment using Terraform. It integrates with Azure for storage and identity, and provisions a complete Databricks workspace setup including clusters, SQL warehouses, catalogs, schemas, external locations, and fine-grained access controls.

---

## 📁 Module Overview

| Module                          | Description                                                                 |
|---------------------------------|-----------------------------------------------------------------------------|
| `databricks_catalog_with_access` | Creates Databricks Unity Catalogs and assigns ownership/access             |
| `databricks_catalog_schema_grants` | Grants schema-level permissions to users or groups                         |
| `databricks_cluster`           | Provisions compute clusters with default policies                          |
| `databricks_identity_access`   | Manages workspace-level access control for users, service principals, etc. |
| `databricks_sql_warehouse`     | Creates SQL Warehouses (formerly endpoints)                                |
| `external_location`            | Defines external locations linked to storage credentials and containers    |
| `storage_container`            | Creates Azure Blob Storage containers for Unity Catalog storage            |
| `storage_credential`           | Creates Databricks storage credentials referencing Azure SAS or MI         |

All modules use the appropriate provider:
- [`databricks`](https://registry.terraform.io/providers/databricks/databricks/latest)
- [`azurerm`](https://registry.terraform.io/providers/hashicorp/azurerm/latest)

---

## 🔐 Secrets and Auth

- Authentication is handled via **OAuth M2M** using service principals.
- Secrets (e.g., Client IDs, Secrets, Access Keys) are injected from Azure Key Vault into Azure DevOps pipelines.
- No secrets are hardcoded in Terraform code or state.

---

## 🏗️ Infrastructure Prerequisites

Ensure the following infrastructure is provisioned **before** running these modules:
- Azure Storage Account and container for remote state
- Databricks Account with Unity Catalog enabled
- SCIM sync configured for identity management (Azure AD to Databricks)
- Azure Key Vault containing:
  - Databricks Account & Workspace credentials
  - Azure Storage Access Key or MI config

---

## 🚀 CI/CD with Azure DevOps

This Terraform project is typically executed using Azure DevOps pipelines with steps:
1. Fetch secrets from Key Vault
2. Export secrets as environment variables
3. Run `terraform init` with a remote backend (Azure Storage)
4. Execute `terraform plan` and `terraform apply`

No `backend.tf` is stored in the repo — the backend config is passed dynamically in the pipeline.

---

## 🔁 Execution Order

To avoid dependency issues, apply modules in the following logical sequence:

1. `storage_container`
2. `storage_credential`
3. `external_location`
4. `databricks_catalog_with_access`
5. `databricks_catalog_schema_grants`
6. `databricks_identity_access`
7. `databricks_cluster`
8. `sql_warehouse`

Alternatively, use a root module that handles dependencies using `depends_on`.

---

## 🧠 Best Practices

- Use `locals` to standardize naming (e.g., for containers, credentials, locations)
- Avoid hardcoding values; pass inputs via `terraform.tfvars` or CI/CD variables
- Protect secrets using `sensitive = true` in variables and `issecret=true` in pipelines
- Use role-based access controls (RBAC) for minimal privilege assignments
- Maintain state locking and versioning on Azure Blob Storage

---

## 📬 Contact & Contribution

For questions, updates, or to contribute:
- Contact: Data Platform Engineering
- PRs: Open a pull request against the `main` branch
- Bugs: Raise an issue in the tracker

---

## 📄 License

Licensed under the MIT License or your organization’s standard license policy.

