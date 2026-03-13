# Day 13 Notes

## Completed
- Added a dedicated AKS subnet in the dev spoke
- Created a user-assigned identity for AKS
- Granted Network Contributor on the AKS subnet to the AKS identity
- Deployed one AKS cluster in the dev spoke
- Verified AKS access with Azure CLI and kubectl

## Key outcome
Phase 2 initial expansion has started. The landing zone now includes a real AKS workload platform component inside the dev spoke.

## Deployed resources
- snet-dev-aks-system
- id-aks-dev-we-01
- role assignment for subnet access
- aks-dev-we-01

## Next step
Day 14 will integrate AKS into the architecture and document how the spoke subnet model maps to future system/app workload intent.
