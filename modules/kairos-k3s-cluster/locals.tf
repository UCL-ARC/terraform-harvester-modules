locals {
  additional_disks = concat(var.additional_disks, [{
    boot_order = 1
    bus        = "virtio"
    name       = "rootdisk"
    type       = "disk"
    size       = var.root_disk_size
  }])

  bundles = concat(var.additional_bundles, [
    {
      target = "quay.io/kairos/community-bundles:kairos-operator_latest"
    },
    {
      target = "quay.io/kairos/community-bundles:system-upgrade-controller_latest"
      values = {
        suc = {
          version = var.suc_version
        }
      }
    }
  ])

  k3s_manifest_dir = "/var/lib/rancher/k3s/server/manifests"

  manifests = concat(var.additional_manifests, [{
    name = "${var.vault_auth_service_account}"
    content = templatefile("${path.module}/templates/user-data/write-files/vault-auth.yaml.tftpl", {
      vault_auth_sa = var.vault_auth_service_account
    })
  }])

  vm_count = var.control_nodes + var.worker_nodes
}
