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

data "azurerm_client_config" "current" {}

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

module "rg_shared_services" {
  source   = "../../modules/resource-group"
  name     = "rg-shared-services-dev"
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

  subnet_nsg_associations = {
    jumpbox = module.nsg_jumpbox.id
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

  subnet_nsg_associations = {
    dev_app = module.nsg_dev_app.id
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

module "nsg_jumpbox" {
  source              = "../../modules/nsg"
  name                = "nsg-jumpbox-dev-we-01"
  location            = var.location
  resource_group_name = module.rg_hub.name
  tags                = local.tags

  security_rules = [
    {
      name                       = "allow-ssh-from-trusted-ip"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = var.trusted_admin_ip
      destination_address_prefix = "*"
    }
  ]
}

module "nsg_dev_app" {
  source              = "../../modules/nsg"
  name                = "nsg-dev-app-dev-we-01"
  location            = var.location
  resource_group_name = module.rg_spoke_dev.name
  tags                = local.tags

  security_rules = [
    {
      name                       = "deny-internet-admin-access"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "Internet"
      destination_address_prefix = "*"
    }
  ]
}

module "jumpbox_vm" {
  source              = "../../modules/linux-vm"
  name                = "vm-jumpbox-dev-we-01"
  location            = var.location
  resource_group_name = module.rg_hub.name
  subnet_id           = module.network_hub.subnet_ids["jumpbox"]
  admin_username      = var.admin_username
  ssh_public_key      = var.ssh_public_key
  vm_size             = "Standard_B2ts_v2"
  public_ip_name      = "pip-jumpbox-dev-we-01"
  nic_name            = "nic-jumpbox-dev-we-01"
  tags                = local.tags
}

module "private_service_example" {
  source                               = "../../modules/private-service-example"
  key_vault_name                       = "kvanselemdevwe01"
  private_endpoint_name                = "pep-kv-shared-dev-we-01"
  location                             = var.location
  key_vault_resource_group_name        = module.rg_shared_services.name
  private_endpoint_resource_group_name = module.rg_spoke_dev.name
  subnet_id                            = module.network_spoke_dev.subnet_ids["dev_private_endpoints"]
  tenant_id                            = data.azurerm_client_config.current.tenant_id
  tags                                 = local.tags
}
