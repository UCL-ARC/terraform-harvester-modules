locals {
  additional_disks = concat(var.additional_disks, [{
    boot_order = 1
    bus        = "virtio"
    name       = "rootdisk"
    type       = "disk"
    size       = var.root_disk_size
  }])
  ips       = var.networks[var.primary_interface].ips
  leader_ip = local.ips[0]
  vm_count  = var.control_nodes + var.worker_nodes
}
