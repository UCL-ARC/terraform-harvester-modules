resource "null_resource" "galaxy" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = join(" ", [
      "ansible-galaxy",
      "install",
      "-r ${path.module}/ansible/requirements.yaml",
      "--force"
    ])
  }
}

resource "ansible_playbook" "k3s_leader" {
  depends_on              = [null_resource.galaxy]
  name                    = var.leader_name
  playbook                = "${path.module}/ansible/playbook.yaml"
  groups                  = ["k3s", "leader"]
  ignore_playbook_failure = false
  replayable              = true
  extra_vars = merge(local.common_ansible_args, local.server_ansible_args, {
    ansible_host        = local.leader_ip
    cluster_api_vip     = var.cluster_api_vip
    cluster_ingress_vip = var.cluster_ingress_vip
    calico_version      = var.calico_version
    k3s_install_args = join(" ", concat(local.k3s_common_install_args, [
      "--node-ip=${local.leader_ip}",
      "--tls-san=${var.cluster_api_vip}",
      "--tls-san=https://${var.cluster_api_vip}.sslip.io",
      "--cluster-init"
    ], var.k3s_extra_install_args_control))
    metallb_version = var.metallb_version
  })
}

resource "ansible_playbook" "k3s_follower" {
  depends_on              = [null_resource.galaxy, ansible_playbook.k3s_leader]
  for_each                = local.followers
  name                    = each.key
  playbook                = "${path.module}/ansible/playbook.yaml"
  groups                  = ["k3s", "follower"]
  ignore_playbook_failure = false
  replayable              = true
  extra_vars = merge(local.common_ansible_args, local.server_ansible_args, {
    ansible_host = each.value
    k3s_install_args = join(" ", concat(local.k3s_common_install_args, [
      "--node-ip=${each.value}",
      "--advertise-address=${each.value}",
      "--server=https://${var.cluster_api_vip}:6443"
    ], var.k3s_extra_install_args_control))
  })
}

resource "ansible_playbook" "k3s_worker" {
  depends_on              = [null_resource.galaxy, ansible_playbook.k3s_follower]
  for_each                = local.workers
  name                    = each.key
  playbook                = "${path.module}/ansible/playbook.yaml"
  groups                  = ["k3s", "worker"]
  ignore_playbook_failure = false
  replayable              = true
  extra_vars = merge(local.common_ansible_args, {
    ansible_host          = each.value
    k3s_role              = "agent"
    k3s_uninstall_command = "/usr/local/bin/k3s-agent-uninstall.sh"
    k3s_url               = "https://${var.cluster_api_vip}:6443"
  })
}

data "local_file" "kubeconfig" {
  depends_on = [ansible_playbook.k3s_leader, ansible_playbook.k3s_follower, ansible_playbook.k3s_worker]
  filename   = "${path.module}/ansible/${local.kubeconfig}"
}
