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
  description = "Trusted public IP allowed to SSH to the jumpbox subnet"
  type        = string
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