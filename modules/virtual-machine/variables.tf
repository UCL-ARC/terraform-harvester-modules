variable "name" {
  type        = string
  description = "Name of the vm"
}

variable "additional_disks" {
  type = list(object({
    auto_delete = optional(bool, true)
    boot_order = number
    bus        = string
    hot_plug   = optional(bool, false)
    name       = string
    mount      = optional(string, "")
    size       = string
    type       = string
  }))
  default = []
}

variable "cloudinit_type" {
  type    = string
  default = "noCloud"
}

variable "cpu" {
  type    = number
  default = 2
}

variable "disk_auto_delete" {
  type    = bool
  default = true
}

variable "disk_boot_order" {
  type    = number
  default = 1
}

variable "disk_bus" {
  type    = string
  default = "virtio"
}

variable "disk_name" {
  type    = string
  default = "rootdisk"
}

variable "disk_size" {
  type    = string
  default = "30Gi"
}

variable "disk_type" {
  type    = string
  default = "disk"
}

variable "efi_boot" {
  type    = bool
  default = false
}

variable "namespace" {
  type        = string
  description = "Name of the namespace into which the VMs with be delployed. It must exist"
}

variable "network_data" {
  type        = string
  description = "Data for cloud-init to use"
  default     = ""
}

variable "networks" {
  type = list(object({
    cidr    = optional(string, "")
    dns     = optional(string, "")
    gateway = optional(string, "")
    iface   = string
    ip      = optional(string, "")
    network = string
  }))

  description = "Map of harvester VM networks to add NICs for"
}

variable "memory" {
  type    = string
  default = "16Gi"
}

variable "run_strategy" {
  type    = string
  default = "RerunOnFailure"
}

variable "ssh_public_key" {
  type = string
  default = ""
}

variable "timeout" {
  type    = string
  default = "10m"
}

variable "user_data" {
  type        = string
  description = "Data for cloud-init to use"
  default = ""
}

variable "vm_description" {
  type        = string
  description = "Description of the VM"
  default     = ""
}

variable "vm_image" {
  type        = string
  description = "OS image to use"
}

variable "vm_image_namespace" {
  type        = string
  description = "OS image namespace to use"
}

variable "vm_tags" {
  type    = map(any)
  default = {}
}

variable "vm_username" {
  type = string
}
