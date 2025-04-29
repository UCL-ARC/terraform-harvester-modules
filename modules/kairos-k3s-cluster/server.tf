module "k3s_server_vm" {
  count  = local.vm_count
  source = "../virtual-machine"

  additional_disks = local.additional_disks
  cpu              = var.cpu
  disk_boot_order  = 2
  disk_bus         = "scsi"
  disk_name        = var.iso_disk_name
  disk_size        = var.iso_disk_size
  disk_type        = "cd-rom"
  efi_boot         = var.efi_boot
  memory           = var.memory
  name             = "${var.cluster_name}-vm-${count.index}"
  namespace        = var.cluster_namespace
  networks = [
    for key, value in var.networks :
    {
      iface   = key
      network = value.network
    }
  ]
  user_data = templatefile("${path.module}/templates/user_data.yaml.tftpl", {
    cluster_vip         = var.cluster_vip
    control_nodes_count = var.control_nodes
    hostname            = "${var.cluster_name}-vm-${count.index}"
    kairos_os_image     = var.root_disk_container_image
    networks = {
      for key, value in var.networks : key =>
      {
        alias   = try(value.alias, "")
        cidr    = try(value.cidr, null)
        dns     = try(value.dns, "")
        gateway = try(value.gateway, "")
        iface   = key
        ip      = try(value.ips[count.index], "")
        network = value.network
      }
    }
    p2p_network_id    = local.p2p_network_id
    p2p_network_token = local.p2p_network_token
    ssh_public_key    = tls_private_key.ssh.public_key_openssh
  })
  vm_image           = var.iso_disk_image
  vm_image_namespace = var.iso_disk_image_namespace
  vm_tags            = var.vm_tags
  vm_username        = var.vm_username
}
