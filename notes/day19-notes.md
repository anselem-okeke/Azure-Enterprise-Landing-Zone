# Day 19 Notes

## Completed
- Created Azure Storage account
- Created blob container
- Created workload identity for Blob access
- Granted Storage Blob Data Contributor
- Federated AKS service account to the Blob identity
- Deployed sample app that uploads and downloads a blob

## Key outcome
The platform now includes a real AKS workload path to Azure Blob Storage using workload identity.

## Vertical slice status
- AKS -> Key Vault -> PostgreSQL: working
- AKS -> Blob Storage via workload identity: implemented
