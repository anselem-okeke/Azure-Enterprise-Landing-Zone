variable "name" {
  description = "VM name"
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

variable "subnet_id" {
  description = "Subnet ID for the VM NIC"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key for admin access"
  type        = string
}

variable "vm_size" {
  description = "Azure VM size"
  type        = string
  default     = "Standard_B2ts_v2"
}

variable "public_ip_name" {
  description = "Public IP resource name"
  type        = string
}

variable "nic_name" {
  description = "NIC resource name"
  type        = string
}

variable "tags" {
  description = "Tags for VM resources"
  type        = map(string)
  default     = {}
}