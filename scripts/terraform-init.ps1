Write-Host "=== DEBUG TERRAFORM EXECUTION ==="

$tfPath = "C:\agent\_work\_tool\terraform\1.14.8\x64\terraform.exe"

if (!(Test-Path $tfPath)) {
    Write-Error "Terraform NOT found!"
    exit 1
}

Write-Host "Terraform found"

$workDir = "$env:BUILD_SOURCESDIRECTORY\terraform\envs\$env:ENV"
Write-Host "Working Directory: $workDir"

Set-Location -Path $workDir

& $tfPath version

$env:TF_LOG = "DEBUG"

Write-Host "Running terraform init..."

& $tfPath init `
  -backend-config="storage_account_name=$env:TFSTATE_STORAGE" `
  -backend-config="container_name=$env:CONTAINERNAME" `
  -backend-config="key=$env:KEY" `
  -backend-config="resource_group_name=$env:TERRAFORM_RG" `
  -backend-config="subscription_id=$env:ARM_SUBSCRIPTION_ID" `
  -backend-config="tenant_id=$env:ARM_TENANT_ID" `
  -backend-config="client_id=$env:ARM_CLIENT_ID" `
  -backend-config="client_secret=$env:ARM_CLIENT_SECRET"

Write-Host "Terraform init completed"