# Day 15 Notes

## Completed
- Moved Terraform state to Azure Storage backend
- Configured GitHub Actions checks and plan workflow
- Implemented Azure OIDC authentication for GitHub Actions
- Added AKS smoke checks to the workflow
- Created a runtime service principal
- Stored runtime service principal details in Key Vault
- Stored database-related secret placeholders in Key Vault

## Key outcome
The platform now has a stronger CI/CD and secret-management foundation:
- remote Terraform state
- Azure-authenticated GitHub plan automation
- AKS validation path
- real Key Vault secret usage beyond architecture validation

## Important design distinction
- GitHub Actions uses OIDC to authenticate to Azure
- Key Vault stores runtime/application secrets and service principal credentials for controlled usage patterns
