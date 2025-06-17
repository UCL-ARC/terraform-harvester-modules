locals {
  additional_disks = concat(var.additional_disks, [{
    boot_order = 1
    bus        = "virtio"
    name       = "rootdisk"
    type       = "disk"
    size       = var.root_disk_size
  }])
  vm_count = var.control_nodes + var.worker_nodes


  yaml_files = fileset("/Users/andrew.esterson/notes/kairos/manifests/", "*.yaml")

  yaml_contents = [
    for file in local.yaml_files :
    file("/Users/andrew.esterson/notes/kairos/manifests/${file}")
  ]
}

output "yaml_file_names" {
  value = local.yaml_files
}

output "yaml_contents_list" {
  value = local.yaml_contents
}
