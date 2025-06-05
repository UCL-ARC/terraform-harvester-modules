variable "cluster_leader_ip" {
  type        = string
  description = "IP address of the k3s cluster leader"
}

variable "cluster_vip" {
  type        = string
  description = "Cluster VIP for the k3s cluster"
}

variable "ssh_common_args" {
  type        = string
  description = "Common SSH arguments for Ansible"
  default     = ""
}

variable "ssh_private_key" {
  type        = string
  description = "SSH private key content for accessing the VM"
  sensitive   = true
}

variable "ssh_signed_public_key" {
  type        = string
  description = "SSH signed public key content for accessing the VM"
  default     = ""
}

variable "vault_kubernetes_secrets_engine_path" {
  type        = string
  description = "Path to the Kubernetes secrets engine in Vault"
}

variable "vault_auth_service_account" {
  type        = string
  description = "Name of the Vault authentication service account"
}

variable "vm_username" {
  type        = string
  description = "Username for the VM"
}
