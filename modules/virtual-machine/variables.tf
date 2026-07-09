variable "name" {
  type        = string
  description = "Name of the vm"
}

variable "additional_disks" {
  type = list(object({
    auto_delete = optional(bool, true)
    boot_order  = number
    bus         = string
    hot_plug    = optional(bool, false)
    name        = string
    mount       = optional(string, "")
    size        = string
    type        = string
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

variable "disks" {
  type = list(object({
    auto_delete     = optional(bool, true)
    boot_order      = number
    bus             = optional(string, "virtio")
    hot_plug        = optional(bool, false)
    image           = optional(string, "")
    image_namespace = optional(string, "")
    name            = string
    mount           = optional(string, "")
    size            = string
    type            = optional(string, "disk")
  }))
  default = []

  validation {
    condition     = length(var.disks) > 0 && length([for k, v in var.disks : v if try(var.disks[k].image, "") != ""]) == 1
    error_message = "At least one disk must be specified and exactly one disk must have an image specified"
  }
}

variable "efi_boot" {
  type    = bool
  default = false
}

variable "namespace" {
  type        = string
  description = "Name of the namespace into which the VMs with be deployed. It must exist"
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
  type    = string
  default = ""
}

variable "timeout" {
  type    = string
  default = "10m"
}

variable "user_data" {
  type        = string
  description = "Data for cloud-init to use"
  default     = ""
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
