variable "cluster_vip" {
  type        = string
  description = "KubeVip virtual IP address"
}

variable "ssh_private_key" {
  type        = string
  description = "Path to the SSH private key to use for the VMs"
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
