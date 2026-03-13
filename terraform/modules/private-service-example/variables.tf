variable "key_vault_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "private_endpoint_name" {
  description = "Name of the private endpoint"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "key_vault_resource_group_name" {
  description = "Resource group for the Key Vault"
  type        = string
}

variable "private_endpoint_resource_group_name" {
  description = "Resource group for the private endpoint"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the private endpoint"
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}

variable "private_dns_zone_ids" {
  description = "List of private DNS zone IDs to associate with the private endpoint"
  type        = list(string)
  default     = []
}