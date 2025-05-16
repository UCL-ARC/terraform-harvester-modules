data "harvester_image" "vm_image" {
  display_name = var.vm_image
  namespace    = var.vm_image_namespace
}

resource "harvester_cloudinit_secret" "user_data_secret" {
  name      = "${var.name}-cloudinit"
  namespace = var.namespace
  user_data = var.user_data != "" ? var.user_data : templatefile("${path.module}/templates/user_data.yaml.tftpl", {
    ssh_public_key   = var.ssh_public_key
    additional_disks = var.additional_disks
  })
}
resource "harvester_virtualmachine" "vm" {
  name                 = var.name
  namespace            = var.namespace
  restart_after_update = true
  run_strategy         = var.run_strategy
  description          = var.vm_description != "" ? var.vm_description : "${data.harvester_image.vm_image.display_name}"
  tags                 = var.vm_tags

  cpu    = var.cpu
  memory = var.memory

  hostname = var.name

  reserved_memory = "100Mi"
  machine_type    = "q35"

  efi = var.efi_boot

  dynamic "network_interface" {
    for_each = var.networks
    content {
      name           = network_interface.value.iface
      network_name   = network_interface.value.network
      wait_for_lease = true
      model          = "virtio"
      type           = "bridge"
    }
  }

  disk {
    name       = var.disk_name
    type       = var.disk_type
    size       = var.disk_size
    bus        = var.disk_bus
    boot_order = var.disk_boot_order

    image       = data.harvester_image.vm_image.id
    auto_delete = var.disk_auto_delete
  }

  dynamic "disk" {
    for_each = var.additional_disks

    content {
      auto_delete = disk.value.auto_delete
      boot_order  = disk.value.boot_order
      bus         = disk.value.bus
      hot_plug    = disk.value.hot_plug
      name        = disk.value.name
      size        = disk.value.size
      type        = disk.value.type
    }
  }

  cloudinit {
    type                  = var.cloudinit_type
    user_data_secret_name = harvester_cloudinit_secret.user_data_secret.name
    network_data          = var.network_data != "" ? var.network_data : templatefile("${path.module}/templates/network_data.yaml.tftpl", {
      networks = var.networks
    })
  }

  timeouts {
    create = var.timeout
    delete = var.timeout
    update = var.timeout
  }
}
