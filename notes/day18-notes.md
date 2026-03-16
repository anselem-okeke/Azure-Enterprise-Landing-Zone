# Day 18 Notes

## Completed
- Deployed a sample Python app into AKS
- Mounted database secrets from Key Vault into the pod
- Used workload identity and Secrets Store CSI integration
- App read database secrets from mounted files
- App attempted a real PostgreSQL connection

## Key outcome
The platform now includes a real runtime path:
AKS workload -> Key Vault secrets -> PostgreSQL connection

## Next step
Add Blob Storage and allow the app to access it.
