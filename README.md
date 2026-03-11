# Azure Enterprise Landing Zone Architecture
![img](./diagrams/azure-landing-zone.drawio.png)


## Overview

This project defines an Azure enterprise-style landing zone based on a hub-and-spoke network architecture.

The design separates shared platform services from workload environments and provides a foundation for secure, scalable, and governable cloud deployments.

The target state includes:
- a central hub network for shared services and administrative access
- isolated spokes for development and production workloads
- a private services zone for internal platform dependencies
- a future CI/CD spoke for private runners and delivery tooling
- a future hybrid connectivity boundary for on-premises or HPC integration

This repository follows a phased approach:
- Phase 1: low-cost proof of concept
- Phase 2: enterprise expansion

## Architecture Objectives

The architecture is designed to achieve the following goals:

- separate shared services from workload networks
- support secure administrative access
- create clear isolation between dev and prod environments
- prepare for private service connectivity
- support future hybrid connectivity patterns
- enable phased implementation with Terraform
- keep the initial deployment cost low during the proof-of-concept stage

## Network Plan

```mermaid
flowchart LR
    subgraph DEV["Dev Spoke"]
        direction TB
        DEVLBL["10.1.0.0/16"]
        subgraph DROW[" "]
            direction LR
            DA["Dev App<br/>10.1.2.0/24"]
            DPE["Dev Private Endpoints<br/>10.1.3.0/24"]
        end
    end

    subgraph PROD["Prod Spoke"]
        direction TB
        PRODLBL["10.2.0.0/16"]
        subgraph PROW[" "]
            direction LR
            PA["Prod App<br/>10.2.2.0/24"]
            PPE["Prod Private Endpoints<br/>10.2.3.0/24"]
        end
    end

    subgraph PRIVATE["Private Services Spoke"]
        direction TB
        PRIVLBL["10.3.0.0/16"]
        subgraph PVTROW[" "]
            direction LR
            PC["Private Core<br/>10.3.1.0/24"]
            PE["Private Endpoints<br/>10.3.2.0/24"]
        end
    end

    subgraph HUB["Hub VNet"]
        direction TB
        HUBLBL["10.0.0.0/16"]
        J["Jumpbox<br/>10.0.1.0/24"]
        SS["Shared Services<br/>10.0.2.0/24"]
        M["Management<br/>10.0.3.0/24"]
        B["Azure Bastion<br/>10.0.10.0/24<br/>Reserved"]
        F["Firewall<br/>10.0.20.0/24<br/>Reserved"]
        G["Gateway<br/>10.0.30.0/24<br/>Reserved"]
    end

    DEV <--> HUB
    PROD <--> HUB
    PRIVATE <--> HUB

    G -.-> HC["Hybrid Connectivity<br/>VPN / ExpressRoute"]
    B -.-> AB["Azure Bastion Future"]
    F -.-> AF["Azure Firewall Future"]
```

## Summary Table

| Zone | VNet CIDR | Subnet | CIDR | Purpose |
|---|---|---|---|---|
| Hub | `10.0.0.0/16` | `snet-jumpbox` | `10.0.1.0/24` | Admin access VM |
| Hub | `10.0.0.0/16` | `snet-shared-services` | `10.0.2.0/24` | Shared platform services |
| Hub | `10.0.0.0/16` | `snet-management` | `10.0.3.0/24` | Future management services |
| Hub | `10.0.0.0/16` | `snet-azurebastion` | `10.0.10.0/24` | Reserved |
| Hub | `10.0.0.0/16` | `snet-firewall` | `10.0.20.0/24` | Reserved |
| Hub | `10.0.0.0/16` | `snet-gateway` | `10.0.30.0/24` | Reserved |
| Dev | `10.1.0.0/16` | `snet-dev-system` | `10.1.1.0/24` | Future platform components |
| Dev | `10.1.0.0/16` | `snet-dev-app` | `10.1.2.0/24` | App workloads |
| Dev | `10.1.0.0/16` | `snet-dev-private-endpoints` | `10.1.3.0/24` | Private endpoint usage |
| Prod | `10.2.0.0/16` | `snet-prod-system` | `10.2.1.0/24` | Future platform components |
| Prod | `10.2.0.0/16` | `snet-prod-app` | `10.2.2.0/24` | App workloads |
| Prod | `10.2.0.0/16` | `snet-prod-private-endpoints` | `10.2.3.0/24` | Private endpoint usage |
| Private Services | `10.3.0.0/16` | `snet-private-core` | `10.3.1.0/24` | Core internal services |
| Private Services | `10.3.0.0/16` | `snet-private-endpoints` | `10.3.2.0/24` | Private endpoint usage |
| CI/CD | `10.4.0.0/16` | `snet-runners` | `10.4.1.0/24` | Private runners |
| CI/CD | `10.4.0.0/16` | `snet-build-agents` | `10.4.2.0/24` | Build/deploy agents |

## Why Hub-and-Spoke

A hub-and-spoke model is used to centralize shared services while keeping workloads isolated in dedicated spoke networks.

This pattern allows:
- shared network services to be placed in one central location
- workload environments to be separated by purpose and risk
- future security controls to be introduced without redesigning the full topology
- clearer operational boundaries between platform infrastructure and hosted applications

In this project, the hub acts as the shared platform network, while each spoke represents a dedicated environment or service domain.

## Hub Network

The hub network is the shared platform zone.

### Purpose
The hub is responsible for central platform connectivity and shared operational services.

### Current PoC role
In Phase 1, the hub contains only the minimum components needed to validate the design:
- hub virtual network
- administrative access subnet
- shared services subnet placeholder
- small Linux jumpbox for controlled access

### Future enterprise role
In a later phase, the hub may also contain:
- Azure Firewall or centralized egress controls
- NAT Gateway
- Private DNS Resolver
- Bastion or hardened administrative access services
- VPN Gateway or ExpressRoute integration
- shared monitoring or platform tooling

## Spoke Networks

### Dev Spoke
The development spoke represents non-production application workloads.

Its purpose is to host development-stage services with clear separation from production resources.

Future examples:
- private AKS development cluster
- internal application services
- development-only dependencies

### Prod Spoke
The production spoke represents production application workloads.

Its purpose is to provide stronger isolation for business-critical services and production deployments.

Future examples:
- private AKS production cluster
- production application services
- production-grade access controls

### Private Services Spoke
The private services spoke represents shared internal platform services that should not be publicly exposed.

Examples include:
- Azure Key Vault
- private storage access
- private database access
- internal service endpoints

In Phase 1, this spoke may be represented by a single private service example such as Key Vault or Storage with private connectivity.

### CI/CD Spoke
The CI/CD spoke is reserved for future private delivery tooling.

Examples include:
- GitHub Actions private runners
- Terraform execution workers
- deployment agents
- internal build or release tooling

This spoke is design-only in the current phase.

### On-Prem / HPC Connectivity Zone
This zone represents a future hybrid connectivity boundary.

It is included in the target architecture to show how external enterprise networks could connect into the landing zone through controlled connectivity.

Examples include:
- on-premises datacenter connectivity
- VPN-based branch connectivity
- HPC or internal compute network integration

## Trust Boundaries

The architecture is divided into multiple trust zones.

### Hub trust boundary
The hub is trusted for shared platform services but should remain tightly controlled because compromise of the hub can affect multiple spokes.

### Dev trust boundary
The development spoke is lower-trust than production and should be isolated to prevent accidental or insecure development activity from affecting production services.

### Prod trust boundary
The production spoke is a higher-trust and higher-protection zone. Access should be restricted and tightly governed.

### Private services trust boundary
Private platform services should only be reachable through approved private connectivity paths and should never rely on broad public exposure by default.

### Hybrid boundary
External or on-premises connectivity is treated as a separate trust domain and must be explicitly controlled before access is allowed into hub or spoke networks.

## High-Level Traffic and Access Model

The intended traffic model is as follows:

- administrative access enters through the hub
- shared services are centralized in the hub
- workload hosting occurs in spokes
- private services are consumed through controlled private connectivity
- development and production spokes remain logically separated
- hybrid or external connectivity is introduced only through controlled boundary services

### Phase 1 access model
During the proof of concept:
- one Linux jumpbox is used for administrative access
- one hub and one spoke are deployed
- one private service example is added
- connectivity is validated through simple hub-to-spoke design

### Future access model
In the enterprise phase:
- bastion or hardened access paths may replace the jumpbox
- centralized firewall and DNS services may be added to the hub
- AKS clusters and private endpoints may be distributed across multiple spokes
- hybrid access may be introduced with VPN Gateway or ExpressRoute

## Phased Implementation

### Phase 1 - Proof of Concept
The first phase is intentionally limited in order to validate the architecture with minimal cost and complexity.

Included in Phase 1:
- documentation and target-state design
- Terraform repository structure
- hub virtual network
- one spoke virtual network
- virtual network peering
- one Linux jumpbox
- one private service example

### Phase 2 - Enterprise Expansion
The second phase extends the proof of concept toward a more complete enterprise landing zone.

Potential additions in Phase 2:
- Azure Firewall
- NAT Gateway
- Private DNS Resolver
- VPN Gateway or ExpressRoute
- dev private AKS cluster
- prod private AKS cluster
- CI/CD private runners spoke
- full private endpoint strategy
- centralized monitoring and security controls

## Summary

This landing zone is designed as a phased Azure platform foundation.

The target architecture reflects an enterprise-style hub-and-spoke model, while the initial implementation focuses on a low-cost proof of concept that validates the most important design elements without attempting full-scale deployment too early.

The result is a design that is both realistic for a trial subscription and extensible toward a more complete private platform architecture.
