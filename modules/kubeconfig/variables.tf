variable "cluster_vip" {
  type        = string
  description = "KubeVip virtual IP address"
}

variable "kubeconfig_path" {
  type        = string
  description = "Path to the kubeconfig file"
  default     = ""
}

variable "ssh_private_key_path" {
  type        = string
  description = "Path to the SSH private key to use for the VMs"
  default = ""
}

variable "ssh_common_args" {
  type    = string
  default = ""
}

variable "vm_ip" {
  type        = string
  description = "IP address of the VM"
}

variable "vm_username" {
  type = string
}
