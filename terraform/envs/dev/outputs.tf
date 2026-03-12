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

output "jumpbox_vm_name" {
  value = module.jumpbox_vm.vm_name
}

output "jumpbox_public_ip" {
  value = module.jumpbox_vm.public_ip_address
}

output "key_vault_name" {
  value = module.private_service_example.key_vault_name
}

output "private_endpoint_name" {
  value = module.private_service_example.private_endpoint_name
}

output "key_vault_private_dns_zone" {
  value = module.private_dns_kv.zone_name
}

output "aks_dev_name" {
  value = module.aks_dev.name
}

output "aks_dev_fqdn" {
  value = module.aks_dev.fqdn
}

output "aks_dev_node_resource_group" {
  value = module.aks_dev.node_resource_group
}