locals {
  disks = [
    {
      boot_order      = 1
      image           = var.vm_image
      image_namespace = var.vm_image_namespace
      name            = "rootdisk"
      size            = var.root_disk_size
    }
  ]
  ips = var.networks[var.primary_interface].ips

  leader_name = "${var.cluster_name}-control-0"

  follower_names = [
    for k in range(1, var.control_nodes) :
    "${var.cluster_name}-control-${k}"
  ]

  worker_names = [
    for k in range(0, var.worker_nodes) :
    "${var.cluster_name}-worker-${k}"
  ]

  vm_names = concat([local.leader_name], local.follower_names, local.worker_names)
  vm_count = length(local.vm_names)
}
