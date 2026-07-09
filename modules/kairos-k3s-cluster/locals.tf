locals {
  additional_disks = concat(var.additional_disks, [{
    boot_order = 1
    bus        = "virtio"
    name       = "rootdisk"
    type       = "disk"
    size       = var.root_disk_size
  }])

  disks = concat([
    {
      boot_order      = 1
      bus             = "virtio"
      image           = var.iso_disk_image == "" ? var.root_disk_image : null
      image_namespace = var.iso_disk_image == "" ? var.root_disk_image_namespace : null
      name            = "rootdisk"
      size            = var.root_disk_size
      type            = "disk"
    }],
    var.iso_disk_image != "" ? [{
      boot_order      = 2
      bus             = "scsi"
      image           = var.iso_disk_image
      image_namespace = var.iso_disk_image_namespace
      name            = var.iso_disk_name
      size            = var.iso_disk_size
      type            = "cd-rom"
  }] : [])

  bundles = concat(var.additional_bundles, [{
    target = "ghcr.io/ucl-arc-environments/kairos-operator-bundle:0.0.1"
  }])

  k3s_manifest_dir = "/var/lib/rancher/k3s/server/manifests"

  manifests = concat(var.additional_manifests, [{
    name = "${var.vault_auth_service_account}"
    content = templatefile("${path.module}/templates/user-data/write-files/vault-auth.yaml.tftpl", {
      vault_auth_sa = var.vault_auth_service_account
    })
  }])

  vm_count = var.control_nodes + var.worker_nodes
}
