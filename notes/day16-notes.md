# Day 16 Notes

## Completed
- Switched PostgreSQL Flexible Server design from private-only to public access with firewall restrictions
- Deployed PostgreSQL Flexible Server in North Europe due subscription/region restrictions in West Europe
- Added firewall rule restricted to the current admin source IP
- Stored real database connection details in Key Vault

## Key outcome
The platform now includes a real managed PostgreSQL database and real runtime secrets in Key Vault, allowing the vertical slice to continue despite subscription restrictions on the original private-access region plan.

## Next step
Enable AKS to consume Key Vault secrets and deploy a sample app that connects to PostgreSQL.
