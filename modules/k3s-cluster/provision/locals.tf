locals {
  leader_ip     = var.ips[0]
  control_nodes = length(concat([var.leader_name], var.follower_names))
  worker_nodes  = length(var.worker_names)
  leader = {
    "${var.leader_name}" = local.leader_ip
  }

  followers = {
    for k, v in slice(var.ips, 1, local.control_nodes) :
    var.follower_names[k] => v
  }

  workers = {
    for k, v in slice(var.ips, local.control_nodes, length(var.ips)) :
    var.worker_names[k] => v
  }

  k3s_common_install_args = [
    "--cluster-cidr=${var.cluster_cidr}",
    "--data-dir=${var.data_dir}",
    "--default-local-storage-path=${var.local_storage_path}",
    "--disable-network-policy",
    "--disable=traefik",
    "--disable=servicelb",
    "--flannel-backend=none",
    "--flannel-iface=${var.primary_interface}", # default interface
    "--selinux",
  ]

  kubeconfig      = "k3s.yaml"
  kubeconfig_path = "./${local.kubeconfig}"

  common_ansible_args = {
    ansible_ssh_private_key_file = local_sensitive_file.ssh_key.filename
    ansible_ssh_common_args = join(" ", [
      "-o StrictHostKeyChecking=accept-new",
      "-o ControlPath=~/%r@%h:%p",
      "-o UserKnownHostsFile=/dev/null",
      var.ssh_common_args
    ])
    ansible_user            = var.vm_username
    cluster_api_vip         = var.cluster_api_vip
    cluster_additional_vips = yamlencode(var.cluster_additional_vips)
    k3s_version             = var.k3s_version
    kubeconfig_path         = local.kubeconfig_path
    leader_ip               = local.leader_ip
    node_token              = local.node_token
    openiscsi_version       = var.openiscsi_version
    private_registries      = yamlencode(var.private_registries)
  }

  server_ansible_args = {
    k3s_role              = "server"
    k3s_uninstall_command = "/usr/local/bin/k3s-uninstall.sh"
  }

  node_token = "${random_string.token_id.result}.${random_string.token_secret.result}"
}
