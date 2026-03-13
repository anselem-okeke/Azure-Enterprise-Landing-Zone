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

## AKS Integration in the Dev Spoke

The Phase 2 initial expansion introduces one AKS cluster into the development spoke.

### Current implementation
The development spoke now includes:
- a dedicated AKS node subnet
- one AKS cluster for non-production workloads
- managed identity-based subnet access for the cluster

### Design intent
The AKS cluster extends the spoke from a network-only boundary into a workload platform boundary.

The subnet model in the development spoke is now interpreted as:
- `snet-dev-aks-system`: AKS node placement
- `snet-dev-app`: future application-facing services or supporting components
- `snet-dev-private-endpoints`: private endpoint consumption for internal Azure services

### Security and network implications
- AKS uses the dedicated subnet rather than sharing placement with private endpoints
- the cluster identity is granted subnet permissions required for AKS networking
- the AKS subnet is kept separate from the private endpoint subnet to reduce role confusion and blast radius

### Current limitation
The AKS API server is not yet implemented as a private-only endpoint.
This keeps the implementation realistic for the current proof-of-concept phase while preserving a future path toward stronger private access models.