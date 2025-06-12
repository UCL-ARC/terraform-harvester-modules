variable "additional_disks" {
  type = list(object({
    boot_order = number
    bus        = string
    name       = string
    mount      = string
    size       = string
    type       = string
  }))
  default = []
}

variable "control_nodes" {
  type        = number
  default     = 3
  description = "Number of control plane nodes to deploy"
}

variable "cluster_name" {
  type        = string
  description = "Name of the cluster used to uniqify the vm names"
}

variable "cluster_namespace" {
  type        = string
  description = "Name of the namespace into which the VMs with be delployed. It must exist"
}

variable "cluster_vip" {
  type        = string
  description = "KubeVip virtual IP address"
}

variable "cpu" {
  type    = number
  default = 4
}

variable "efi_boot" {
  type    = bool
  default = false
}

variable "iso_disk_image" {
  type        = string
  description = "OS image to use"
}

variable "iso_disk_image_namespace" {
  type        = string
  description = "OS image  namespace to use"
}

variable "iso_disk_name" {
  type    = string
  default = "iso-cdrom"
}

variable "iso_disk_size" {
  type    = string
  default = "30Gi"
}

variable "k3s_extra_args" {
  type        = list(string)
  description = "Extra arguments to pass to k3s"
  default     = []
}

variable "k3s_oidc_admin_binding_name" {
  type        = string
  description = "OIDC admin binding name to use for the cluster"
  default     = "cluster-admin"
}

variable "k3s_oidc_admin_group" {
  type        = string
  description = "OIDC admin group to use for the cluster"
  default     = ""
}

variable "k3s_oidc_args" {
  type        = list(string)
  description = "Extra arguments to pass to k3s"
  default     = []
}

variable "kairos_bind_mounts" {
  type        = list(string)
  description = "List paths to make persistent on the hosts."
  default     = []
}

variable "memory" {
  type    = string
  default = "32Gi"
}

variable "networks" {
  type = map(object({
    alias   = string
    ips     = optional(list(string), [])
    cidr    = number
    gateway = string
    dns     = string
    network = string
  }))
  description = "Map of harvester VM networks to add NICs for. Key should be interface name."
}

variable "primary_interface" {
  type        = string
  description = "Name of the primary network interface"
  default     = "eth0"
}

variable "private_registries" {
  type        = list(map(string))
  description = "List of private container image registries to use in the cluster"
  default     = []
}

variable "root_disk_container_image" {
  type    = string
  default = ""
}

variable "root_disk_size" {
  type    = string
  default = "30Gi"
}

variable "ssh_admin_principals" {
  type        = list(string)
  description = "List of SSH principals to use for the VMs"
  default     = []
}

variable "ssh_ca_public_key" {
  type        = string
  description = "SSH CA public key to use for the VMs"
  default     = ""
  validation {
    condition     = var.ssh_ca_public_key != "" || var.ssh_public_key != ""
    error_message = "Set one of ssh_ca_public_key or ssh_public_key"
  }
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key to use for the VMs"
  default     = ""
}

variable "ssh_common_args" {
  type    = string
  default = ""
}

variable "system_upgrade_controller_version" {
  type        = string
  description = "Version of the system upgrade controller to install in the cluster."
  default     = "v0.15.2"
}

variable "vault_auth_service_account" {
  type        = string
  description = "Service account to use for the vault auth"
  default     = "vault-auth"
}

variable "vm_tags" {
  type = map(any)
}

variable "vm_username" {
  type = string
}

variable "worker_nodes" {
  type        = number
  description = "Number of worker nodes to deploy"
  default     = 0
}
