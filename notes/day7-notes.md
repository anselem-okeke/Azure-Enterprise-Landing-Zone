# Day 7 Notes
```mermaid
flowchart LR
    subgraph PLATFORM["Azure Landing Zone - Phase 1 Network Foundation"]
        subgraph HUB_RG["rg-hub-network-dev"]
            subgraph HUB_VNET["vnet-hub-dev-we-01<br/>10.0.0.0/16"]
                JUMP["snet-jumpbox"]
                SHARED["snet-shared-services"]
            end
        end

        subgraph DEV_RG["rg-spoke-dev-network"]
            subgraph DEV_VNET["vnet-spoke-dev-we-01<br/>10.1.0.0/16"]
                APP["snet-dev-app"]
                PEP["snet-dev-private-endpoints"]
            end
        end
    end

    HUB_VNET <-->|peer-hub-to-dev-we-01| DEV_VNET
    DEV_VNET <-->|peer-dev-to-hub-we-01| HUB_VNET

    VALID["Validation<br/>RGs created<br/>VNets provisioned<br/>Peerings connected<br/>Tags visible"] -.-> PLATFORM
```
Successfully deployed the Phase 1 Azure landing zone network foundation using Terraform.

Deployed components:
- rg-hub-network-dev
- rg-spoke-dev-network
- vnet-hub-dev-we-01 (10.0.0.0/16)
- vnet-spoke-dev-we-01 (10.1.0.0/16)
- hub subnets:
  - snet-jumpbox
  - snet-shared-services
- dev spoke subnets:
  - snet-dev-app
  - snet-dev-private-endpoints
- bidirectional VNet peering:
  - peer-hub-to-dev-we-01
  - peer-dev-to-hub-we-01

Validation:
- resource groups created successfully
- VNets provisioned successfully
- peerings are connected and fully in sync
- Terraform tags are visible in Azure

## Completed
- Logged into Azure with Azure CLI
- Verified the active subscription
- Initialized Terraform
- Validated the configuration
- Reviewed the first network plan
- Applied the Phase 1 network foundation
- Verified resource groups, VNets, subnets, and peerings

## Key outcome
The Azure landing zone PoC now has a real deployed network foundation in Azure.

## Deployed resources
- rg-hub-network-dev
- rg-spoke-dev-network
- vnet-hub-dev-we-01
- vnet-spoke-dev-we-01
- snet-jumpbox
- snet-shared-services
- snet-dev-app
- snet-dev-private-endpoints
- peer-hub-to-dev-we-01
- peer-dev-to-hub-we-01

## Next step
Day 8 will add the first NSG controls and tighten the network baseline.
