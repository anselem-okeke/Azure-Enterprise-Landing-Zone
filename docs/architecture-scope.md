# Azure Enterprise Landing Zone - Scope

## Objective
Design an Azure enterprise-style landing zone based on a hub-and-spoke architecture.

## Main goals
- Build a portfolio-grade Azure architecture
- Keep the first implementation low-cost
- Deploy only a small proof of concept during the trial
- Leave enterprise-scale components as future phases

## Target architecture
- Hub network for shared services
- Dev AKS spoke
- Prod AKS spoke
- Private services spoke
- GitHub Actions / private runners spoke
- On-prem / HPC connectivity placeholder

## Delivery approach
- Phase 1: Design + low-cost proof of concept
- Phase 2: Enterprise expansion

## Phase 1 PoC
- Hub VNet
- One spoke VNet
- VNet peering
- One Linux jumpbox
- One private service example
- Basic security model
- Terraform foundation

## Phase 2 Enterprise
- Azure Firewall / NAT Gateway
- Private DNS Resolver
- ExpressRoute / VPN Gateway
- Dev AKS private cluster
- Prod AKS private cluster
- GitHub Actions private runners spoke
- Full private endpoint model
- Full enterprise monitoring stack

## Hub responsibilities
The hub network will centralize:
- Shared network connectivity
- Administrative access path
- Future security controls
- Future DNS/private connectivity services

For the PoC, the hub will contain:
- Hub VNet
- Admin subnet / jumpbox subnet
- Shared services subnet placeholder

## Spokes
### Dev Spoke
Represents non-production application landing zone.

### Prod Spoke
Represents production application landing zone.

### Private Services Spoke
Represents shared private-access services such as Key Vault, Storage, and Database access patterns.

### CI/CD Spoke
Represents future private runners and deployment tooling.

### On-Prem / HPC
Represents future hybrid connectivity boundary only.