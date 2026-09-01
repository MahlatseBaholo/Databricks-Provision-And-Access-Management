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
# Databricks Governance Action Plan — Sasol AES Platform

**Created:** September 2026  
**Owner:** Data Operations / Platform Team  
**Scope:** DEV, PREPROD, PROD workspaces  
**Reference:** MACC Agreement 56942A05F0EA — USD 34M over 36 months (March 2025 – February 2028)

---

## Table of Contents

1. [PAT Token Expiry Policy](#1-pat-token-expiry-policy)
2. [Service Principal Credential Rotation](#2-service-principal-credential-rotation)
3. [Emergency Break-Glass Accounts](#3-emergency-break-glass-accounts)
4. [Combined Implementation Timeline](#4-combined-implementation-timeline)
5. [RACI Matrix](#5-raci-matrix)
6. [Appendix: Terraform Snippets](#6-appendix-terraform-snippets)

---

## 1. PAT Token Expiry Policy

### 1.1 Objective

Enforce maximum personal access token (PAT) lifetimes and restrict token creation to authorised roles only. Prevent indefinite API access from leaked or forgotten tokens.

### 1.2 Current State & Risk

- **7 roles** currently have CAN_USE on Token: Data Engineer, Data Scientist, ML Engineer, Data Analyst, Data Owner, Auditor, FinOps Specialist
- **No lifetime governance** — a leaked PAT grants indefinite API access until manually revoked
- **No creation restrictions** — any workspace user can generate tokens by default
- **No expiry notifications** — users are unaware when tokens are about to expire

### 1.3 Target Token Lifetimes

| Environment | Max Lifetime | Rationale |
| --- | --- | --- |
| DEV | 90 days | Frequent iteration, lower risk |
| PREPROD | 60 days | Pre-production validation, moderate risk |
| PROD | 30 days | Production access, highest risk |

### 1.4 Action Items

| # | Action | Owner | Timeline | Detail |
| --- | --- | --- | --- | --- |
| 1.1 | Set workspace-level max token lifetime | Workspace Admin | Week 1 | Set `maxTokenLifetimeDays` via Admin Console → Settings → Token Management (or API `PATCH /api/2.0/workspace-conf`). Apply per-workspace with environment-appropriate lifetimes (90/60/30 days). |
| 1.2 | Restrict token creation to approved roles | Workspace Admin | Week 1 | In Token Management, toggle "Restrict token creation". Allowlist only AD groups that need PATs: Data Engineer, Data Scientist, ML Engineer, Data Analyst, FinOps Specialist, Auditor. Remove implicit all-users access. |
| 1.3 | Document PAT request process | Data Operations | Week 2 | Users must justify PAT creation via ServiceNow/IT ticket. Include: purpose, expiry date, target workspace, and which external tool requires it. |
| 1.4 | Build expiry notification job | Platform Team | Week 3 | Scheduled Databricks job that queries `system.access.audit` for token creation events. Sends email/Teams notification to token owners 7 days before expiry. |
| 1.5 | Quarterly PAT audit | Auditor | Recurring (Q1/Q2/Q3/Q4) | Review active tokens via `GET /api/2.0/token-management/tokens` (admin-only API). Revoke orphaned tokens (user departed, purpose expired, exceeded lifetime). |
| 1.6 | Integrate with Azure Monitor | Security Team | Week 4 | Forward token creation/deletion events from Databricks audit logs to Azure Sentinel for centralised security monitoring. |

### 1.5 Token Policy Enforcement Query

```sql
-- Identify tokens exceeding policy lifetime or approaching expiry
SELECT
  t.created_by AS user_email,
  t.token_id,
  t.creation_time,
  t.expiry_time,
  DATEDIFF(t.expiry_time, CURRENT_TIMESTAMP()) AS days_until_expiry,
  CASE
    WHEN t.expiry_time IS NULL THEN 'NO EXPIRY SET - VIOLATION'
    WHEN DATEDIFF(t.expiry_time, t.creation_time) > 90 THEN 'EXCEEDS MAX LIFETIME'
    WHEN DATEDIFF(t.expiry_time, CURRENT_TIMESTAMP()) <= 7 THEN 'EXPIRING SOON'
    ELSE 'COMPLIANT'
  END AS policy_status
FROM system.access.audit AS t
WHERE t.action_name = 'tokenCreate'
ORDER BY policy_status, days_until_expiry
```

---

## 2. Service Principal Credential Rotation

### 2.1 Objective

Rotate all 6 service principal client secrets on a scheduled cadence with zero-downtime deployments. Prevent compromised SP credentials from granting persistent access.

### 2.2 Service Principal Inventory

| SP Name | Environment | Risk Level | Purpose |
| --- | --- | --- | --- |
| `sasol-prod-aes-terraform-deploy` | PROD | **Critical** | Infrastructure provisioning (compute, warehouses, policies, secrets) |
| `sasol-prod-aes-databricks-bundle-deploy` | PROD | **Critical** | Application deployment (jobs, pipelines, notebooks — IS_OWNER) |
| `sasol-preprod-aes-terraform-deploy` | PREPROD | **High** | Infrastructure provisioning |
| `sasol-preprod-aes-databricks-bundle-deploy` | PREPROD | **High** | Application deployment |
| `sasol-dev-aes-terraform-deploy` | DEV | **Medium** | Infrastructure provisioning |
| `sasol-dev-aes-databricks-bundle-deploy` | DEV | **Medium** | Application deployment |

### 2.3 Rotation Cadence

| Environment | Rotation Frequency | Rationale |
| --- | --- | --- |
| PROD | Every 90 days | Highest privilege (IS_OWNER on jobs/pipelines), highest risk |
| PREPROD | Every 120 days | Similar privileges, lower blast radius |
| DEV | Every 180 days | Lower risk, developer-driven |

### 2.4 Dual-Secret Overlap Rotation Process

Entra ID supports 2 active secrets per app registration, enabling zero-downtime rotation:

```
Day 0:  Create Secret B in Entra ID (Secret A still active)
        ├── Both secrets are now valid
Day 1:  Update Azure Key Vault with Secret B
        ├── CI/CD pipelines pick up Secret B on next run
Day 2:  Verify all pipelines run successfully with Secret B
        ├── Monitor: Terraform plans, bundle deploys, scheduled jobs
Day 3-6: Observation period — confirm no failures
Day 7:  Delete Secret A from Entra ID
        ├── Only Secret B remains active
        └── Log rotation completion in governance tracker
```

### 2.5 Action Items

| # | Action | Owner | Timeline | Detail |
| --- | --- | --- | --- | --- |
| 2.1 | Establish rotation cadence | Security / Platform | Week 1 | Document 90/120/180-day policy per environment. Get sign-off from Security and Data Operations. |
| 2.2 | Migrate credentials to Azure Key Vault | Platform Team | Week 2 | Each SP's `client_secret` stored in a dedicated Key Vault per environment (`kv-aes-dev`, `kv-aes-preprod`, `kv-aes-prod`). CI/CD pipelines pull from KV at runtime — never from pipeline variables or repo files. |
| 2.3 | Implement dual-secret rotation runbook | Platform Team | Week 3 | Document the 7-day overlap process above. Include rollback steps: if Secret B fails, revert KV to Secret A and investigate. |
| 2.4 | Automate rotation | Platform Team | Week 4 | Azure Automation Runbook or GitHub Actions workflow: create new secret → update KV → test connectivity → wait 7 days → delete old secret → send Teams notification. |
| 2.5 | Alert on rotation overdue | Security | Week 4 | Azure Monitor alert if a Key Vault secret hasn't been updated within the cadence window (+7 day grace). Escalates to Platform Team. |
| 2.6 | Alert on anomalous SP usage | Security | Week 2 | Query `system.access.audit` for SP authentication events not originating from CI/CD IP ranges (Azure DevOps/GitHub hosted runners). Any unexpected SP login = P2 security incident. |
| 2.7 | Quarterly SP access review | Auditor | Recurring | Verify each SP's actual permissions match the RBAC matrix. Identify and remediate drift (e.g., someone manually granted extra access via UI). |

### 2.6 Anomalous SP Usage Detection Query

```sql
-- Detect SP authentications outside expected CI/CD patterns
SELECT
  a.service_principal AS sp_name,
  a.source_ip_address,
  a.action_name,
  a.event_time,
  a.request_params,
  CASE
    WHEN a.source_ip_address NOT IN (
      -- Replace with your CI/CD runner IP ranges
      '20.37.194.0/24',   -- Azure DevOps hosted agents
      '40.74.28.0/23'     -- GitHub Actions runners
    ) THEN 'ANOMALOUS - INVESTIGATE'
    ELSE 'EXPECTED'
  END AS risk_assessment
FROM system.access.audit a
WHERE a.service_principal IS NOT NULL
  AND a.event_date >= CURRENT_DATE() - INTERVAL 7 DAYS
ORDER BY risk_assessment DESC, a.event_time DESC
```

---

## 3. Emergency Break-Glass Accounts

### 3.1 Objective

Ensure Databricks admin access is recoverable even if the AES-ADMIN AD group, AES-DATAOPERATIONS group, or Entra ID Conditional Access fails. Prevent total lockout scenarios.

### 3.2 Current Risk

- If the AES-ADMIN group is corrupted, deleted, or all members are locked out by Conditional Access, **nobody can administer any workspace**
- If Entra ID MFA is down, AD-synced accounts cannot authenticate
- No documented recovery procedure exists
- Individual user (`eswar.nagireddy@de.sasol.com`) as Metastore Admin = single point of failure

### 3.3 Break-Glass Account Design

| Attribute | Account 1 | Account 2 |
| --- | --- | --- |
| **UPN** | `breakglass-admin-01@sasol.com` | `breakglass-admin-02@sasol.com` |
| **Account Type** | Cloud-only (NOT synced from on-prem AD) | Cloud-only |
| **Databricks Role** | Account Admin (direct assignment, not via group) | Account Admin (direct assignment) |
| **MFA Method** | FIDO2 hardware key (YubiKey) | FIDO2 hardware key (YubiKey) |
| **Conditional Access** | Excluded from ALL CA policies | Excluded from ALL CA policies |
| **Password Storage** | Sealed envelope in physical safe, Site A | Sealed envelope in physical safe, Site B |
| **FIDO2 Key Storage** | Physical safe, Site A (dual-person access) | Physical safe, Site B (dual-person access) |

### 3.4 Action Items

| # | Action | Owner | Timeline | Detail |
| --- | --- | --- | --- | --- |
| 3.1 | Create 2 dedicated break-glass accounts | Identity / Security | Week 1 | Cloud-only accounts in Entra ID. Assign Databricks Account Admin directly (not via group membership). Do NOT add to AES-ADMIN or AES-DATAOPERATIONS. |
| 3.2 | Exclude from Conditional Access | Identity / Security | Week 1 | Exclude both accounts from ALL CA policies: MFA, device compliance, location restrictions, session controls. These accounts must work even when CA itself is the problem. |
| 3.3 | Enrol with FIDO2 hardware keys | Identity / Security | Week 1 | Purchase 4 YubiKeys (2 primary + 2 backup). Register one primary + one backup per break-glass account. Store in separate physical safes requiring dual-person access. |
| 3.4 | Store credentials securely | Identity / Security | Week 1 | Passwords in sealed envelopes in physical safes at two separate locations. NOT in Azure Key Vault (KV may be inaccessible during the emergency). |
| 3.5 | Configure sign-in monitoring | Security / SOC | Week 2 | Azure Sentinel alert: ANY sign-in attempt (success or failure) to either break-glass account triggers P1 incident notification to Security team + IT management + CISO. |
| 3.6 | Write break-glass runbook | Platform Team | Week 2 | Document: (a) when to use, (b) who authorises, (c) how to access credentials, (d) post-use actions (change passwords, review audit logs, file incident report). |
| 3.7 | Add to RBAC matrix | Governance | Week 1 | New row: "Break-Glass Admin" — CAN_MANAGE on everything, all environments. AD Group = "Direct Assignment (cloud-only)". |
| 3.8 | Quarterly testing | Platform + Security | Recurring | Every 90 days: (a) log in to each account, (b) verify Account Admin + workspace access across DEV/PREPROD/PROD, (c) rotate passwords, (d) verify FIDO2 keys work, (e) document test results with sign-off. |

### 3.5 Break-Glass Decision Tree

```
Can any member of AES-ADMIN access Databricks normally?
├── YES → Do NOT use break-glass. Troubleshoot the individual issue.
└── NO
    ├── Is it a Conditional Access / MFA outage?
    │   ├── YES → Use break-glass (CA-excluded accounts bypass the outage)
    │   └── NO
    │       ├── Is the AES-ADMIN AD group intact in Entra ID?
    │       │   ├── NO → Use break-glass (direct assignment survives group deletion)
    │       │   └── YES → Troubleshoot individual account issues
    │       │       └── If still blocked after 30 minutes → Use break-glass
    │       └── Is Entra ID itself down?
    │           └── YES → Escalate to Microsoft Support + use break-glass
    │               (cloud-only accounts may still work via cached tokens)

After ANY break-glass usage:
1. Change both account passwords immediately
2. Review all actions taken during the session via audit logs
3. File a P1 incident report
4. Conduct root cause analysis within 48 hours
5. Update runbook if new failure mode was discovered
```

### 3.6 Post-Incident Checklist

- [ ] Both break-glass passwords rotated
- [ ] Audit logs reviewed for all actions during break-glass session
- [ ] P1 incident report filed in ServiceNow
- [ ] Root cause identified and documented
- [ ] Preventive measures implemented (if applicable)
- [ ] CISO briefed on incident
- [ ] Break-glass runbook updated (if new failure mode)
- [ ] Next quarterly test scheduled

---

## 4. Combined Implementation Timeline

| Week | Token Policy | SP Rotation | Break-Glass |
| --- | --- | --- | --- |
| **1** | Set max lifetimes (90/60/30) + restrict creation | Define cadence + get sign-off | Create accounts + FIDO2 keys + CA exclusions |
| **2** | Document PAT request process | Migrate secrets to Key Vault + anomaly alerts | Configure Sentinel monitoring + write runbook |
| **3** | Build expiry notification job | Implement dual-secret automation | — |
| **4** | Integrate with Azure Sentinel | Alert on rotation overdue | — |
| **Ongoing** | Quarterly PAT audit | Quarterly SP access review + 90/120/180-day rotation | Quarterly break-glass test |

### Milestones & Go/No-Go Gates

| Milestone | Target Date | Go/No-Go Criteria |
| --- | --- | --- |
| Token policy enforced (all 3 workspaces) | End of Week 1 | Max lifetime set, creation restricted, verified via test token |
| All SP secrets in Key Vault | End of Week 2 | 6 SPs migrated, CI/CD pipelines verified, no hardcoded secrets |
| Break-glass accounts operational | End of Week 2 | Both accounts tested, monitoring active, runbook published |
| Automation complete | End of Week 4 | Expiry notifications running, SP rotation automated, all alerts firing |
| First quarterly review | End of Quarter | All 3 audits completed, findings documented, remediation tracked |

---

## 5. RACI Matrix

| Activity | Platform Team | Security | Identity (Entra) | Data Operations | Auditor | CISO |
| --- | --- | --- | --- | --- | --- | --- |
| Token lifetime policy | R | C | I | A | I | I |
| Token creation restriction | R | C | I | A | I | I |
| PAT audit (quarterly) | C | C | I | I | R | I |
| SP credential rotation | R | A | C | I | I | I |
| SP anomaly detection | C | R | I | I | C | I |
| SP access review | C | C | I | I | R | I |
| Break-glass account creation | C | A | R | I | I | I |
| Break-glass monitoring | C | R | C | I | I | I |
| Break-glass testing (quarterly) | R | A | C | I | I | I |
| Break-glass incident response | R | R | C | I | I | A |

**R** = Responsible, **A** = Accountable, **C** = Consulted, **I** = Informed

---

## 6. Appendix: Terraform Snippets

### 6.1 Token Lifetime Policy

```hcl
# Apply per workspace (DEV/PREPROD/PROD)
resource "databricks_workspace_conf" "token_policy" {
  custom_config = {
    "maxTokenLifetimeDays" = var.token_max_lifetime_days  # 90/60/30
    "enableTokensConfig"   = "true"
  }
}

variable "token_max_lifetime_days" {
  description = "Maximum PAT lifetime in days"
  type        = string
  default     = "90"

  validation {
    condition     = tonumber(var.token_max_lifetime_days) <= 90
    error_message = "Token lifetime must not exceed 90 days per security policy."
  }
}
```

### 6.2 Service Principal Configuration

```hcl
# Example: Bundle deployment SP with per-environment secrets from Key Vault
data "azurerm_key_vault_secret" "bundle_sp_secret" {
  name         = "bundle-deploy-client-secret"
  key_vault_id = var.key_vault_id
}

resource "databricks_service_principal" "bundle_deploy" {
  application_id = var.bundle_sp_application_id
  display_name   = "sasol-${var.environment}-aes-databricks-bundle-deploy"
  active         = true
}

# Grant workspace-level permissions per RBAC matrix
resource "databricks_permissions" "bundle_sp_jobs" {
  authorization = "jobs"
  access_control {
    service_principal_name = databricks_service_principal.bundle_deploy.application_id
    permission_level       = var.environment == "dev" ? "CAN_MANAGE" : "IS_OWNER"
  }
}
```

### 6.3 Key Vault Secret Rotation (Azure Automation)

```powershell
# Azure Automation Runbook - SP Secret Rotation
param(
    [string]$AppRegistrationId,
    [string]$KeyVaultName,
    [string]$SecretName,
    [int]$NewSecretValidityDays = 90
)

# Connect with Managed Identity
Connect-AzAccount -Identity

# Create new client secret in Entra ID
$endDate = (Get-Date).AddDays($NewSecretValidityDays)
$newSecret = New-AzADAppCredential `
    -ApplicationId $AppRegistrationId `
    -EndDate $endDate

# Update Key Vault
Set-AzKeyVaultSecret `
    -VaultName $KeyVaultName `
    -Name $SecretName `
    -SecretValue (ConvertTo-SecureString $newSecret.SecretText -AsPlainText -Force) `
    -Expires $endDate

# Tag with rotation metadata
Update-AzKeyVaultSecret `
    -VaultName $KeyVaultName `
    -Name $SecretName `
    -Tag @{
        "RotatedOn"    = (Get-Date -Format "yyyy-MM-dd")
        "ExpiresOn"    = $endDate.ToString("yyyy-MM-dd")
        "RotatedBy"    = "Azure-Automation"
        "AppId"        = $AppRegistrationId
    }

Write-Output "Secret rotated successfully. New expiry: $endDate"
Write-Output "IMPORTANT: Delete old secret from Entra ID after 7-day verification period."
```

---

## Document History

| Version | Date | Author | Changes |
| --- | --- | --- | --- |
| 1.0 | September 2026 | Data Operations / Platform Team | Initial action plan covering Token, SP rotation, and break-glass |

---

*This document should be reviewed quarterly alongside the RBAC Permissions Matrix and updated as Sasol's Databricks platform evolves.*
