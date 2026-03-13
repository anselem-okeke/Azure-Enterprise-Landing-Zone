variable "zone_name" {
  description = "Private DNS zone name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for the private DNS zone"
  type        = string
}

variable "location" {
  description = "Location placeholder for module consistency"
  type        = string
  default     = "global"
}

variable "virtual_network_links" {
  description = "Map of virtual network links"
  type = map(object({
    name                 = string
    virtual_network_id   = string
    registration_enabled = optional(bool, false)
  }))
  default = {}
}

variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
  default     = {}
}
