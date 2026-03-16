variable "name" {
  description = "PostgreSQL Flexible Server name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "administrator_login" {
  description = "Admin username"
  type        = string
}

variable "administrator_password" {
  description = "Admin password"
  type        = string
  sensitive   = true
}

variable "postgres_version" {
  description = "PostgreSQL version"
  type        = string
  default     = "16"
}

variable "sku_name" {
  description = "SKU name"
  type        = string
  default     = "B_Standard_B1ms"
}

variable "storage_mb" {
  description = "Storage in MB"
  type        = number
  default     = 32768
}

variable "public_access" {
  description = "Enable public network access"
  type        = bool
  default     = true
}

variable "firewall_rules" {
  description = "Firewall rules for public access"
  type = list(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))
  default = []
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}















#variable "name" {
#  description = "PostgreSQL Flexible Server name"
#  type        = string
#}
#
#variable "location" {
#  description = "Azure region"
#  type        = string
#}
#
#variable "resource_group_name" {
#  description = "Resource group name"
#  type        = string
#}
#
#variable "database_location" {
#  default = "northeurope"
#}
#
#variable "administrator_login" {
#  description = "Admin username"
#  type        = string
#}
#
#variable "administrator_password" {
#  description = "Admin password"
#  type        = string
#  sensitive   = true
#}
#
#variable "postgres_version" {
#  description = "PostgreSQL version"
#  type        = string
#  default     = "17"
#}
#
#variable "delegated_subnet_id" {
#  description = "Delegated subnet ID for private access"
#  type        = string
#}
#
#variable "private_dns_zone_id" {
#  description = "Private DNS zone ID for PostgreSQL"
#  type        = string
#}
#
#variable "sku_name" {
#  description = "SKU name"
#  type        = string
#  default     = "B_Standard_B2s"
#}
#
#variable "storage_mb" {
#  description = "Storage in MB"
#  type        = number
#  default     = 32768
#}
#
#variable "tags" {
#  description = "Tags"
#  type        = map(string)
#  default     = {}
#}
