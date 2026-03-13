# Day 8 Notes

## Completed
- Added NSG module
- Created jumpbox NSG
- Created dev app NSG
- Associated NSGs to subnets
- Restricted SSH access to trusted public IP for jumpbox subnet
- Denied direct internet SSH access to dev app subnet

## Key outcome
The landing zone now has its first subnet-level security baseline in Azure.

## Implemented controls
- jumpbox subnet protected by dedicated NSG
- dev app subnet protected by dedicated NSG
- no direct broad internet SSH path into app subnet

## Next step
Day 9 will deploy the small Linux jumpbox VM into the secured hub subnet.
