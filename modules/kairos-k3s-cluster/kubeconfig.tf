resource "ansible_playbook" "kubeconfig" {
  depends_on              = [module.k3s_server_vm]
  name                    = "kubeconfig"
  playbook                = "${path.module}/playbook.yaml"
  groups                  = ["leader"]
  ignore_playbook_failure = false
  replayable              = true
  extra_vars = {
    ansible_host                 = local.leader_ip
    ansible_user                 = var.vm_username
    ansible_ssh_private_key_file = var.ssh_private_key_path
    ansible_ssh_common_args = join(" ", [
      "-o StrictHostKeyChecking=accept-new",
      "-o ControlPath=~/%r@%h:%p",
      var.ssh_common_args
    ])
    cluster_vip     = var.cluster_vip
    kubeconfig_path = local.kubeconfig_path
  }
}

data "local_file" "kubeconfig" {
  depends_on = [ansible_playbook.kubeconfig]
  filename   = "${path.module}/${local.kubeconfig}"
}
