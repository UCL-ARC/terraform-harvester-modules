locals {
  kubeconfig_filename = "k3s_kubeconfig.yaml"
}

resource "local_sensitive_file" "ssh_private_key" {
  content  = var.ssh_private_key
  filename = "${path.module}/ssh-private-key"
}

resource "ansible_playbook" "kubeconfig" {
  name                    = "kubeconfig"
  playbook                = "${path.module}/playbook.yaml"
  groups                  = ["leader"]
  ignore_playbook_failure = false
  replayable              = true
  extra_vars = {
    ansible_host                 = var.vm_ip
    ansible_user                 = var.vm_username
    ansible_ssh_private_key_file = local_sensitive_file.ssh_private_key.filename
    ansible_ssh_common_args = join(" ", [
      "-o StrictHostKeyChecking=accept-new",
      "-o ControlPath=~/%r@%h:%p",
      "-o UserKnownHostsFile=/dev/null",
      var.ssh_common_args
    ])
    cluster_vip     = var.cluster_vip
    kubeconfig_path = "./${local.kubeconfig_filename}"
  }
}

data "local_file" "kubeconfig" {
  depends_on = [ansible_playbook.kubeconfig]
  filename   = "${path.module}/${local.kubeconfig_filename}"
}
