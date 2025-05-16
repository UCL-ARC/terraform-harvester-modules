variable "appstream_repo_url" {
  type        = string
  default     = ""
  description = "URL to use to obtain AppStream repository for yum/dnf"
}

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

variable "baseos_repo_url" {
  type        = string
  default     = ""
  description = "URL to use to obtain BaseOS repository for yum/dnf"
}

variable "calico_version" {
  type        = string
  description = "Version of Calico to install. See: https://github.com/projectcalico/calico/releases"
  default     = "v3.28.1"
}

variable "control_nodes" {
  type        = number
  description = "Number of control plane nodes to deploy"
}

variable "cluster_name" {
  type        = string
  description = "Name of the cluster used to uniqify the vm names"
}

variable "cluster_api_vip" {
  type        = string
  description = "MetalLB Virtual IP address to assign for the API server"
}

variable "cluster_ingress_vip" {
  type        = string
  description = "MetalLB Virtual IP address to assign for the Ingress controller"
}

variable "cpu" {
  type    = number
  default = 4
}

variable "data_dir" {
  type    = string
  default = "/var/lib/rancher/k3s"
}

variable "efi_boot" {
  type    = bool
  default = false
}

variable "k3s_version" {
  type        = string
  description = "Version of k3s to install on Harvester VMs. See: https://github.com/k3s-io/k3s/releases"
  default     = "v1.30.2+k3s1"
}

variable "local_storage_path" {
  type        = string
  description = "Path to use for local storage on Harvester VMs"
  default     = "/var/lib/rancher/k3s/storage"
}

variable "memory" {
  type    = string
  default = "32Gi"
}

variable "networks" {
  type = map(object({
    ips     = list(string)
    cidr    = number
    gateway = string
    dns     = string
    network = string
  }))
  description = "Map of harvester VM networks to add NICs for. Key should be interface name."
}

variable "namespace" {
  type        = string
  description = "Name of the namespace into which the VMs with be delployed. It must exist"
}

variable "metallb_version" {
  type        = string
  description = "Version of metallb to install on Harvester VMs."
  default     = "v0.14.8"
}

variable "openiscsi_version" {
  type        = string
  description = "Version of openiscsi to install on Harvester VMs."
  default     = ""
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

variable "root_disk_size" {
  type    = string
  default = "30Gi"
}

variable "run_strategy" {
  type    = string
  default = "RerunOnFailure"
}

variable "ssh_common_args" {
  type    = string
  default = ""
}

variable "vm_count" {
  type        = number
  default     = 3
  description = "How many VMs to create"
}

variable "vm_image" {
  type        = string
  description = "OS image to use"
}

variable "vm_image_namespace" {
  type        = string
  description = "OS image  namespace to use"
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
