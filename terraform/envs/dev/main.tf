locals {
  tags = {
    environment = var.environment
    owner       = var.owner
    project     = var.project
    managed-by  = var.managed_by
    cost-center = var.cost_center
    phase       = var.phase
  }
}

module "rg_hub" {
  source   = "../../modules/resource-group"
  name     = "rg-hub-network-dev"
  location = var.location
  tags     = local.tags
}

module "rg_spoke_dev" {
  source   = "../../modules/resource-group"
  name     = "rg-spoke-dev-network"
  location = var.location
  tags     = local.tags
}

module "network_hub" {
  source              = "../../modules/network"
  resource_group_name = module.rg_hub.name
  location            = var.location
  vnet_name           = "vnet-hub-dev-we-01"
  address_space       = ["10.0.0.0/16"]

  subnets = {
    jumpbox = {
      name           = "snet-jumpbox"
      address_prefix = "10.0.1.0/24"
    }
    shared_services = {
      name           = "snet-shared-services"
      address_prefix = "10.0.2.0/24"
    }
  }

  tags = local.tags
}

module "network_spoke_dev" {
  source              = "../../modules/network"
  resource_group_name = module.rg_spoke_dev.name
  location            = var.location
  vnet_name           = "vnet-spoke-dev-we-01"
  address_space       = ["10.1.0.0/16"]

  subnets = {
    dev_app = {
      name           = "snet-dev-app"
      address_prefix = "10.1.2.0/24"
    }
    dev_private_endpoints = {
      name           = "snet-dev-private-endpoints"
      address_prefix = "10.1.3.0/24"
    }
  }

  tags = local.tags
}

module "peer_hub_to_dev" {
  source                    = "../../modules/vnet-peering"
  name                      = "peer-hub-to-dev-we-01"
  resource_group_name       = module.rg_hub.name
  virtual_network_name      = module.network_hub.vnet_name
  remote_virtual_network_id = module.network_spoke_dev.vnet_id
}

module "peer_dev_to_hub" {
  source                    = "../../modules/vnet-peering"
  name                      = "peer-dev-to-hub-we-01"
  resource_group_name       = module.rg_spoke_dev.name
  virtual_network_name      = module.network_spoke_dev.vnet_name
  remote_virtual_network_id = module.network_hub.vnet_id
}