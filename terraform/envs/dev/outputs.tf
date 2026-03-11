output "hub_resource_group" {
  value = module.rg_hub.name
}

output "dev_spoke_resource_group" {
  value = module.rg_spoke_dev.name
}

output "hub_vnet_name" {
  value = module.network_hub.vnet_name
}

output "dev_spoke_vnet_name" {
  value = module.network_spoke_dev.vnet_name
}

output "hub_subnet_ids" {
  value = module.network_hub.subnet_ids
}

output "dev_spoke_subnet_ids" {
  value = module.network_spoke_dev.subnet_ids
}