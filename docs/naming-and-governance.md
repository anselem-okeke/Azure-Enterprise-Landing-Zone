# Naming and Governance Model

## Purpose

This document defines how Azure resources are organized, named, and tagged in the landing zone.

The goal is to ensure:
- consistent resource naming
- clear ownership and environment separation
- easier operations and troubleshooting
- Terraform-friendly structure
- a governance model that can scale from proof of concept to enterprise deployment

## Subscription Strategy

### Current Phase 1 Approach
The proof of concept uses a single Azure subscription.

This is sufficient for:
- low-cost experimentation
- Terraform-based deployment
- validating the hub-and-spoke design
- documenting the platform foundation

### Future Enterprise Approach
In a larger enterprise deployment, environments may be separated across subscriptions, for example:
- shared platform subscription
- development subscription
- production subscription
- connectivity or security subscription

For this project, the architecture is designed so that it can later expand into a multi-subscription model without requiring a redesign.

## Resource Group Strategy

Resources are grouped by function and environment.

### Phase 1 Resource Groups
The initial proof of concept uses the following resource groups:

- `rg-hub-network-dev`
- `rg-spoke-dev-network`
- `rg-shared-services-dev`

### Purpose
- `rg-hub-network-dev` contains hub networking resources
- `rg-spoke-dev-network` contains the first development spoke resources
- `rg-shared-services-dev` contains low-cost shared platform examples such as a private service test resource

### Future Expansion
In later phases, additional resource groups may be added, such as:
- `rg-spoke-prod-network`
- `rg-cicd-platform-dev`
- `rg-platform-security-dev`
- `rg-platform-monitoring-dev`

## Naming Convention

The naming convention follows a structured pattern:

`<resource-type>-<workload>-<environment>-<region>-<instance>`

### Elements
- `resource-type`: short Azure resource prefix
- `workload`: logical purpose or domain
- `environment`: dev, prod, shared
- `region`: short Azure region code
- `instance`: sequence number for uniqueness

### Examples
- `vnet-hub-dev-we-01`
- `vnet-spoke-dev-we-01`
- `subnet-jumpbox-dev-we-01`
- `nsg-jumpbox-dev-we-01`
- `vm-jumpbox-dev-we-01`
- `pip-jumpbox-dev-we-01`
- `stprivate-shared-dev-we-01`

## Standard Short Codes

### Environment Codes
- `dev` = development
- `prod` = production
- `shared` = shared platform services

### Region Codes
- `we` = West Europe
- `neu` = North Europe

### Resource Type Prefixes
- `rg` = resource group
- `vnet` = virtual network
- `snet` = subnet
- `nsg` = network security group
- `vm` = virtual machine
- `nic` = network interface
- `pip` = public IP
- `kv` = Key Vault
- `st` = storage account
- `peer` = VNet peering

## Naming Rules

The following rules apply:

- names should be lowercase where Azure permits
- names should be readable and consistent
- abbreviations should be standardized
- environment must always be visible in the name
- region should be included for deployable resources
- instance numbers should be used where future scaling is likely
- names should reflect function, not temporary implementation details

## Tagging Strategy

All deployed resources should include a standard tag set.

### Required Tags
- `environment`
- `owner`
- `project`
- `managed-by`
- `cost-center`
- `phase`

### Example Values
- `environment=dev`
- `owner=anselem`
- `project=azure-landing-zone`
- `managed-by=terraform`
- `cost-center=lab`
- `phase=poc`

## Phase 1 Governance Rules

The proof of concept uses lightweight governance rules:

- all resources must belong to a defined resource group
- all resources must follow the naming convention
- all resources must include required tags
- only low-cost resources are allowed in Phase 1
- production resources are not deployed in the proof of concept
- network structure must follow the documented CIDR plan
- future enterprise services remain design-only unless explicitly approved for deployment

## Future Governance Direction

In a later enterprise phase, governance may be extended with:

- Azure Policy for required tags and allowed SKUs
- RBAC role separation by environment
- management groups for subscription hierarchy
- budget alerts and cost controls
- deployment guardrails for region and resource types
- stricter controls for production and shared services

## Phase 1 Example Resource Names

### Resource Groups
- `rg-hub-network-dev`
- `rg-spoke-dev-network`
- `rg-shared-services-dev`

### Networking
- `vnet-hub-dev-we-01`
- `vnet-spoke-dev-we-01`
- `nsg-jumpbox-dev-we-01`
- `peer-hub-to-dev-we-01`
- `peer-dev-to-hub-we-01`

### Compute
- `vm-jumpbox-dev-we-01`
- `nic-jumpbox-dev-we-01`
- `pip-jumpbox-dev-we-01`

### Shared Service Example
- `kv-shared-dev-we-01`
or
- `stshareddevwe01`

## Summary

> This naming and governance model provides a consistent structure for organizing Azure resources in the landing zone.
> It keeps the proof of concept simple while preparing the project for later expansion into a more governed enterprise platform model.
