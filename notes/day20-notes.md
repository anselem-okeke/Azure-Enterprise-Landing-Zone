# Day 20 Notes

## Completed
- Added Terraform checks workflow
- Added Terraform plan workflow with OIDC-based Azure auth
- Added AKS application deploy workflow
- Organized Kubernetes manifests under k8s/app-demo
- Prepared enterprise-style CI/CD structure for the landing zone

## Key outcome
The platform now has a real CI/CD foundation:
- infrastructure checks
- non-destructive Terraform planning
- AKS application deployment automation

## CI/CD Workflows

The repository uses GitHub Actions with Azure OIDC authentication.

### terraform-dev.yml
Handles:
- terraform fmt check
- terraform init (backend disabled for checks)
- terraform validate
- terraform plan
- optional AKS smoke checks

### app-deploy.yml
Handles:
- AKS manifest deployment
- post-deploy Kubernetes checks

### Authentication model
- GitHub Actions uses OIDC for Azure authentication
- application/runtime secrets are stored in Key Vault
- AKS workloads use workload identity for Azure resource access
