# Day 17 Notes

## Completed
- Enabled AKS workload identity
- Enabled Azure Key Vault Secrets Provider add-on
- Created user-assigned managed identity for app workloads
- Granted Key Vault secret access to app identity
- Created federated credential between AKS service account and managed identity
- Created SecretProviderClass for Key Vault secrets
- Mounted Key Vault secrets into a test pod

## Key outcome
AKS can now consume runtime secrets from Key Vault without baking secrets into images or Kubernetes manifests.

## Next step
Deploy a sample application that reads the mounted database secrets and connects to PostgreSQL.
