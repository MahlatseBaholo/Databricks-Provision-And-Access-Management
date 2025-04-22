# Unity Catalog Terraform Setup

This project sets up Azure Databricks Unity Catalog, metastore assignment, and dynamic access control using Terraform.

## Structure

- `terraform/` — Main IaC logic
- `modules/catalogs` — Catalog/schema creation and access grants
- `access.yaml` — AD group permissions
- `azure-pipelines.yml` — CI/CD pipeline for Azure DevOps
- `scripts/` — Optional pre-deployment validation

## Getting Started
- Set your workspace and metastore IDs
- Define access groups in `access.yaml`
- Configure Azure backend and service connections
- Commit and push to trigger pipeline
