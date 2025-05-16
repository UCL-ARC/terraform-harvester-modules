module "k3s_server_vm" {
  count  = local.vm_count
  source = "../virtual-machine"

  additional_disks = var.additional_disks
  cpu              = var.cpu
  disk_size        = var.root_disk_size
  efi_boot         = var.efi_boot
  memory           = var.memory
  name             = local.vm_names[count.index]
  namespace        = var.namespace
  networks = [
    for key, value in var.networks :
    {
      cidr    = try(value.cidr, null)
      dns     = try(value.dns, "")
      gateway = try(value.gateway, "")
      iface   = key
      ip      = try(value.ips[count.index], "")
      network = value.network
    }
  ]
  run_strategy    = var.run_strategy
  user_data = templatefile("${path.module}/templates/user_data.yaml.tftpl", {
    additional_disks   = try(var.additional_disks, "")
    appstream_repo_url = var.appstream_repo_url
    baseos_repo_url    = var.baseos_repo_url
    ssh_public_key     = tls_private_key.ssh.public_key_openssh
  })
  vm_image           = var.vm_image
  vm_image_namespace = var.vm_image_namespace
  vm_tags            = var.vm_tags
  vm_username        = var.vm_username
}

module "install_k3s" {
  depends_on = [module.k3s_server_vm]
  source     = "./provision"

  calico_version      = var.calico_version
  cluster_api_vip     = var.cluster_api_vip
  cluster_ingress_vip = var.cluster_ingress_vip
  data_dir            = var.data_dir
  follower_names      = local.follower_names
  ips                 = module.k3s_server_vm.*.ip
  k3s_version         = var.k3s_version
  leader_name         = local.leader_name
  local_storage_path  = var.local_storage_path
  metallb_version     = var.metallb_version
  openiscsi_version   = var.openiscsi_version
  primary_interface   = var.primary_interface
  private_registries  = var.private_registries
  ssh_common_args     = var.ssh_common_args
  ssh_private_key     = tls_private_key.ssh.private_key_openssh
  vm_username         = var.vm_username
  worker_names        = local.worker_names
}
