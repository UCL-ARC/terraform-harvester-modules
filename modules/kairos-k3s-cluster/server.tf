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
  user_data = templatefile("${path.module}/templates/user-data/user-data.yaml.tftpl", {
    install = templatefile("${path.module}/templates/user-data/install.yaml.tftpl", {
      bind_mounts     = var.kairos_bind_mounts
      kairos_os_image = var.root_disk_container_image
    })
    users = templatefile("${path.module}/templates/user-data/users.yaml.tftpl", {
      ssh_public_key = var.ssh_public_key
    })
    stages = templatefile("${path.module}/templates/user-data/stages.yaml.tftpl", {
      boot = templatefile("${path.module}/templates/user-data/stages/boot.yaml.tftpl", {
        k3s_oidc_args               = var.k3s_oidc_args
        k3s_oidc_admin_binding_name = var.k3s_oidc_admin_binding_name
        k3s_oidc_admin_group        = var.k3s_oidc_admin_group
      })
      initramfs = templatefile("${path.module}/templates/user-data/stages/initramfs.yaml.tftpl", {
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
        vault_auto_ca        = var.vault_auto_ca.enabled
        vault_ca_service = templatefile("${path.module}/templates/user-data/stages/vault-ca-service.tftpl", {
          default_ca           = var.vault_auto_ca.default_ca
          krl_url              = var.vault_auto_ca.krl_url
          ssh_admin_principals = var.ssh_admin_principals
          vault_addr           = var.vault_auto_ca.vault_addr
          vault_mount          = var.vault_auto_ca.vault_ssh_mount_path
        })
      })
    })
    p2p = templatefile("${path.module}/templates/user-data/p2p.yaml.tftpl", {
      cluster_vip         = var.cluster_vip
      control_nodes_count = var.control_nodes - 1
      p2p_network_id      = local.p2p_network_id
      p2p_network_token   = local.p2p_network_token
    })
    k3s = templatefile("${path.module}/templates/user-data/k3s-args.yaml.tftpl", {
      k3s_extra_args       = var.k3s_extra_args
      k3s_oidc_args        = var.k3s_oidc_args
      k3s_oidc_admin_group = var.k3s_oidc_admin_group
    })
    bundles = templatefile("${path.module}/templates/user-data/bundles.yaml.tftpl", {
      bundles = [
        for b in local.bundles : {
          target = "run://${b.target}"
          values = b.values != null ? replace(yamlencode(b.values), "/((?:^|\n)[\\s-]*)\"([\\w-]+)\":/", "$1$2:") : ""
        }
      ]
    })
    write_files = templatefile("${path.module}/templates/user-data/write-files.yaml.tftpl", {
      files = [
        for m in local.manifests : {
          dest        = "${local.k3s_manifest_dir}/${m.name}.yaml"
          permissions = 0644
          content     = m.content
        }
      ]
    })
  })
  vm_image           = var.iso_disk_image
  vm_image_namespace = var.iso_disk_image_namespace
  vm_tags            = var.vm_tags
  vm_username        = var.vm_username
}
