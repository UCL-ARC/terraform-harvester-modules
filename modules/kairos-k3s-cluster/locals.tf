locals {
  additional_disks = concat(var.additional_disks, [{
    boot_order = 1
    bus        = "virtio"
    name       = "rootdisk"
    type       = "disk"
    size       = var.root_disk_size
  }])
  vm_count = var.control_nodes + var.worker_nodes

  additional_manifests_contents = [
    for manifest in var.additional_manifests :
    startswith(manifest.path, "/") ? templatefile(manifest.path, manifest.templatevars) : templatefile("${path.root}/${manifest.path}", manifest.templatevars)
  ]
}
