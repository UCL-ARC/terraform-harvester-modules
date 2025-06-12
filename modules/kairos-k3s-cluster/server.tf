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
  network_data = null
  user_data = templatefile("${path.module}/templates/user-data.yaml.tftpl", {
    install = templatefile("${path.module}/templates/install.yaml.tftpl", {
      kairos_os_image = var.root_disk_container_image
    })
    users = templatefile("${path.module}/templates/users.yaml.tftpl", {
      ssh_public_key = var.ssh_public_key
    })
    stages = templatefile("${path.module}/templates/stages.yaml.tftpl", {
      boot = templatefile("${path.module}/templates/boot-stage.yaml.tftpl", {
        k3s_oidc_args               = var.k3s_oidc_args
        k3s_oidc_admin_binding_name = var.k3s_oidc_admin_binding_name
        k3s_oidc_admin_group        = var.k3s_oidc_admin_group
      })
      initramfs = templatefile("${path.module}/templates/initramfs-stage.yaml.tftpl", {
        hostname = "${var.cluster_name}-vm-${count.index}"
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
        ssh_admin_principals = var.ssh_admin_principals
        ssh_ca_public_key    = var.ssh_ca_public_key
      })
    })
    p2p = templatefile("${path.module}/templates/p2p.yaml.tftpl", {
      cluster_vip         = var.cluster_vip
      control_nodes_count = var.control_nodes - 1
      p2p_network_id      = local.p2p_network_id
      p2p_network_token   = local.p2p_network_token
    })
    k3s = templatefile("${path.module}/templates/k3s-args.yaml.tftpl", {
      k3s_extra_args       = var.k3s_extra_args
      k3s_oidc_args        = var.k3s_oidc_args
      k3s_oidc_admin_group = var.k3s_oidc_admin_group
    })
    bundles = file("${path.module}/files/bundles.yaml")
    write_files = templatefile("${path.module}/templates/write-files.yaml.tftpl", {
      files = [{
        path        = "/var/lib/rancher/k3s/server/manifests/${var.vault_auth_service_account}.yaml"
        permissions = 0644
        content = templatefile("${path.module}/templates/vault-auth.yaml.tftpl", {
          vault_auth_sa = var.vault_auth_service_account
        })
      }]
    })
  })
  vm_image           = var.iso_disk_image
  vm_image_namespace = var.iso_disk_image_namespace
  vm_tags            = var.vm_tags
  vm_username        = var.vm_username
}
