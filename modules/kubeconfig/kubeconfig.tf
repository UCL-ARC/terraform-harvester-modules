resource "ansible_playbook" "kubeconfig" {
  name                    = "kubeconfig"
  playbook                = "${path.module}/playbook.yaml"
  groups                  = ["leader"]
  ignore_playbook_failure = false
  replayable              = true
  extra_vars = {
    ansible_host                 = var.vm_ip
    ansible_user                 = var.vm_username
    ansible_ssh_private_key_file = var.ssh_private_key_path
    ansible_ssh_common_args = join(" ", [
      "-o StrictHostKeyChecking=accept-new",
      "-o ControlPath=~/%r@%h:%p",
      "-o UserKnownHostsFile=/dev/null",
      var.ssh_common_args
    ])
    cluster_vip     = var.cluster_vip
    kubeconfig_path = "${path.module}/${var.kubeconfig_path}"
  }
}

data "local_file" "kubeconfig" {
  depends_on = [ansible_playbook.kubeconfig]
  filename   = "${path.module}/${var.kubeconfig_path}"
}
