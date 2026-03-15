variable "location" {
  description = "Azure region for the deployment"
  type        = string
  default     = "westeurope"
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "azure-landing-zone"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "owner" {
  description = "Resource owner"
  type        = string
  default     = "anselem"
}

variable "managed_by" {
  description = "Management tool"
  type        = string
  default     = "terraform"
}

variable "cost_center" {
  description = "Cost center tag"
  type        = string
  default     = "lab"
}

variable "phase" {
  description = "Project phase"
  type        = string
  default     = "poc"
}

variable "trusted_admin_ip" {
  description = "Initial trusted admin IP for SSH access"
  type        = string
  default     = "127.0.0.1/32"
}

variable "admin_username" {
  description = "Admin username for the Linux jumpbox VM"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "SSH public key content for the Linux jumpbox VM"
  type        = string
}

variable "aks_vm_size" {
  description = "VM size for AKS system node pool"
  type        = string
  default     = "Standard_B2ts_v2"
}

variable "aks_node_count" {
  description = "Node count for AKS system node pool"
  type        = number
  default     = 1
}