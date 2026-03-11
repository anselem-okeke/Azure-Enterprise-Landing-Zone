variable "name" {
  description = "Peering name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the source VNet"
  type        = string
}

variable "virtual_network_name" {
  description = "Source virtual network name"
  type        = string
}

variable "remote_virtual_network_id" {
  description = "Remote virtual network ID"
  type        = string
}

variable "allow_virtual_network_access" {
  description = "Allow VNet access"
  type        = bool
  default     = true
}

variable "allow_forwarded_traffic" {
  description = "Allow forwarded traffic"
  type        = bool
  default     = false
}