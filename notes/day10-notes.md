# Day 10 Notes

```mermaid
flowchart LR
    Internet((Internet))

    subgraph HUB["Hub VNet: vnet-hub-dev-we-01 (10.0.0.0/16)"]
        JSubnet["snet-jumpbox"]
        SSubnet["snet-shared-services"]
        Jumpbox["vm-jumpbox-dev-we-01"]
        JNSG["NSG: nsg-jumpbox-dev-we-01\nSSH only from trusted IP"]
        JSubnet --> Jumpbox
        JNSG --- JSubnet
    end

    subgraph DEV["Dev Spoke VNet: vnet-spoke-dev-we-01 (10.1.0.0/16)"]
        AppSubnet["snet-dev-app"]
        PESubnet["snet-dev-private-endpoints"]
        AppNSG["NSG: nsg-dev-app-dev-we-01\nDeny direct internet SSH"]
        PE["Private Endpoint:\npep-kv-shared-dev-we-01"]
        AppNSG --- AppSubnet
        PESubnet --> PE
    end

    subgraph SHARED["Shared Services RG"]
        KV["Key Vault"]
        PDNS["Private DNS Zone:\nprivatelink.vaultcore.azure.net"]
    end

    Internet -->|SSH from trusted IP only| Jumpbox

    HUB <-->|VNet Peering| DEV

    PE --> KV
    PDNS --- PE
    PDNS -. VNet Link .- HUB
    PDNS -. VNet Link .- DEV

    Jumpbox -. private DNS resolution path .-> PDNS
    Jumpbox -. access over peered network/private endpoint path .-> KV
```

## Completed
- Implemented private service example module
- Deployed shared services resource group
- Deployed Azure Key Vault
- Deployed private endpoint into dev private-endpoints subnet
- Verified private-service architecture pattern in Azure

## Key outcome
The landing zone now includes a private-service example, extending the architecture beyond networking and compute into private platform service connectivity.

## Deployed resources
- rg-shared-services-dev
- Key Vault
- Private Endpoint in snet-dev-private-endpoints

# Day 10 Step 2 Notes

## Completed
- Implemented Private DNS support for the Key Vault private endpoint
- Created the private DNS zone for Key Vault private link
- Linked the private DNS zone to the hub VNet
- Linked the private DNS zone to the dev spoke VNet
- Attached the private endpoint to the private DNS zone using a DNS zone group
- Extended the landing zone from basic private endpoint deployment to private name resolution support

## Key outcome
The landing zone now supports private DNS resolution for the Key Vault private endpoint, making the private-service design more realistic and aligned with enterprise private-access architecture.

## Implemented resources
- Private DNS zone: privatelink.vaultcore.azure.net
- Hub VNet link to private DNS zone
- Dev spoke VNet link to private DNS zone
- Private DNS zone group on the Key Vault private endpoint

## Architectural value
This step completed the missing DNS layer required for a functional private endpoint pattern.
The environment now includes:
- hub-and-spoke networking
- secured jumpbox access
- Key Vault private endpoint
- private DNS integration

## Next recommended hardening step
- Validate private name resolution from the jumpbox
- Then disable public network access on the Key Vault after confirming private resolution works

## Next step
Day 11 will focus on documentation cleanup, diagram updates, and aligning the repo with the deployed PoC state.
