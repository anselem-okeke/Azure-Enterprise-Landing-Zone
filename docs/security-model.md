# Security Model

## Purpose

This document defines the security model for the Azure landing zone.

The goal is to establish:
- clear trust boundaries
- controlled administrative access
- workload isolation between environments
- a private-first service access strategy
- a phased path from low-cost proof of concept to stronger enterprise controls

## Security Principles

The landing zone follows these core principles:

- least privilege by default
- separation of duties between shared platform and workload zones
- administrative access through controlled paths only
- development and production isolation
- private connectivity preferred over public exposure
- small proof of concept first, stronger centralized controls later

## Trust Zones

The landing zone is divided into the following trust zones:

### Hub Trust Zone
The hub is the shared platform trust zone.
It contains shared connectivity and administrative entry points.
Because it can influence multiple spokes, it is treated as a high-impact zone and must remain tightly controlled.

### Dev Trust Zone
The development spoke is a lower-trust workload zone.
It is used for non-production services and must not have unrestricted pathways into production resources.

### Prod Trust Zone
The production spoke is a higher-protection workload zone.
It requires stronger access control and should remain isolated from lower-trust zones.

### Private Services Trust Zone
The private services spoke contains internal platform dependencies that should not be broadly exposed.
Access should occur through approved private connectivity paths only.

### External / Hybrid Trust Zone
Any on-premises or external network is treated as a separate trust domain.
Connectivity into Azure must be explicitly governed and never assumed trusted by default.

## Administrative Access Model

### Phase 1
Administrative access is provided through a single small Linux jumpbox deployed in the hub network.

Rules for Phase 1:
- only the jumpbox receives administrative access
- SSH should be restricted to a known trusted source IP where possible
- no broad administrative access is allowed directly into workload spokes
- the jumpbox is used only as a controlled management entry point

### Future Enterprise Direction
In a later phase, the jumpbox may be replaced or supplemented by:
- Azure Bastion
- stronger identity-based access controls
- centralized logging and session monitoring
- hardened administrative workflows

## Network Segmentation Model

Network segmentation is used to reduce blast radius and enforce workload separation.

### Segmentation Rules
- hub and spokes use separate non-overlapping address spaces
- development and production are separated into different VNets
- shared platform access is centralized in the hub
- direct spoke-to-spoke communication is not assumed by default
- private services are separated from general workload placement
- future hybrid connectivity is introduced only through explicit boundary controls

## Network Security Group Strategy

Network Security Groups are used as the first-layer traffic control at subnet or NIC level in the proof of concept.

### Phase 1 NSG Intent
- restrict inbound access to the jumpbox
- allow only required management traffic
- deny unnecessary inbound exposure
- keep spoke subnets tightly scoped
- avoid permissive any-any rules

### NSG Design Direction
- jumpbox subnet: allow SSH only from trusted source IPs
- shared services subnet: allow only explicitly required traffic
- dev app subnet: allow only traffic required for the proof of concept
- private endpoint subnet: no unnecessary inbound administrative exposure

### General Rules
- inbound rules should be explicit
- outbound rules should remain minimal and purposeful
- rules should be named clearly by intent
- temporary troubleshooting rules must not become permanent design

## Phase 1 NSG Baseline

### Jumpbox Subnet
Allowed:
- inbound SSH from trusted public IP only
- outbound access required for administration and package installation

Denied:
- broad inbound internet access
- unnecessary management ports
- unrestricted source ranges

### Dev App Subnet
Allowed:
- traffic only from approved management path if needed
- traffic required for the specific PoC workload

Denied:
- direct administrative exposure from the internet
- unrestricted lateral access by default

### Shared Services / Private Access Areas
Allowed:
- only service-specific traffic required by the PoC

Denied:
- public administrative exposure
- broad cross-subnet access without justification

## Private Access Strategy

The landing zone follows a private-first direction for internal platform services.

### Intent
Where supported, internal platform services should be accessed through private connectivity rather than broad public endpoints.

### Examples
- Key Vault via private endpoint
- Storage via private endpoint
- database services via private endpoint in future phases

### Phase 1
Phase 1 may include one private service example only.
This is intended to validate the design pattern without deploying a full private services platform.

### Future Direction
In later phases:
- more services can move behind private endpoints
- public network access can be disabled where appropriate
- hub-based DNS patterns can be added to support private name resolution

## Identity and Privilege Intent

The proof of concept uses a simple access model, but the design intent is clear:

- administrative permissions should be limited to only what is needed
- shared platform resources should be controlled separately from workload resources
- production access must remain stricter than development access
- future expansion should use stronger RBAC separation by environment and function

## Security Logging and Monitoring Intent

### Phase 1
The proof of concept does not attempt to build a full enterprise SOC stack in Azure.

However, the design expects:
- activity visibility for deployed resources
- basic operational review of changes
- documentation of security-relevant configuration choices

### Future Direction
Later phases may add:
- centralized diagnostic settings
- Log Analytics integration
- Defender-related controls
- alerting for administrative or network changes
- stronger monitoring of private access paths

## Future Centralized Security Controls

The following controls are intentionally reserved for future enterprise phases:

- Azure Firewall for centralized egress and traffic inspection
- Azure Bastion for stronger administrative access patterns
- Private DNS Resolver for private endpoint name resolution at scale
- Azure Policy for tag, SKU, and deployment guardrails
- stricter RBAC separation across shared, dev, and prod scopes
- hybrid boundary controls for VPN Gateway or ExpressRoute connectivity

## Phase 1 vs Future Scope

### Included in Phase 1
- one jumpbox for controlled administration
- basic NSG controls
- isolated hub and dev spoke
- no direct production deployment
- one optional private service example
- documented trust boundaries

### Not Included in Phase 1
- Azure Firewall
- Azure Bastion
- production spoke deployment
- hybrid connectivity
- centralized DNS resolver
- full private endpoint platform rollout
- enterprise SOC/monitoring stack

## Summary

> This security model gives the landing zone a controlled and realistic foundation.
> It keeps the proof of concept intentionally simple while aligning the design toward stronger future controls such as centralized access, private service connectivity, and tighter platform governance.


