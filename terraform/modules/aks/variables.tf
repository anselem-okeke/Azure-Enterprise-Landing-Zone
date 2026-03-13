variable "name" {
  description = "AKS cluster name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for AKS"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for AKS"
  type        = string
}

variable "kubernetes_version" {
  description = "Optional Kubernetes version"
  type        = string
  default     = null
}

variable "node_subnet_id" {
  description = "Subnet ID for AKS nodes"
  type        = string
}

variable "identity_id" {
  description = "User-assigned identity ID for AKS"
  type        = string
}

variable "node_count" {
  description = "Default node count"
  type        = number
  default     = 1
}

variable "vm_size" {
  description = "Default node VM size"
  type        = string
}

variable "tags" {
  description = "Tags for AKS"
  type        = map(string)
  default     = {}
}
