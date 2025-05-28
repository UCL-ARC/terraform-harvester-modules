resource "random_string" "dht_key" {
  length  = 32
  special = false
}

resource "random_string" "crypto_key" {
  length  = 32
  special = false
}

resource "random_string" "room" {
  length  = 32
  special = false
}

resource "random_string" "rendezvous" {
  length  = 32
  special = false
}

resource "random_string" "mdns" {
  length  = 32
  special = false
}

locals {
  p2p_network_id = "${var.cluster_name}-p2p-network"
  p2p_network_token = base64encode(templatefile("${path.module}/templates/edgevpn.yaml.tftpl", {
    crypto_key = upper(random_string.crypto_key.result)
    dht_key    = upper(random_string.dht_key.result)
    mdns       = random_string.mdns.result
    rendezvous = random_string.rendezvous.result
    room       = random_string.room.result
  }))
}
