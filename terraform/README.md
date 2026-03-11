# Terraform Layout

This folder contains the Terraform structure for the Azure landing zone proof of concept.

## Structure

- `envs/dev` - root configuration for the Phase 1 PoC
- `modules/resource-group` - resource group module
- `modules/network` - VNet, subnet, NSG module
- `modules/vnet-peering` - VNet peering module
- `modules/linux-vm` - jumpbox VM module
- `modules/private-service-example` - optional private service example module

## Initial deployment scope

The first implementation will deploy:
- hub resource group
- dev spoke resource group
- hub VNet
- dev spoke VNet
- selected subnets
- NSGs
- VNet peering

Later steps may add:
- Linux jumpbox
- one private service example