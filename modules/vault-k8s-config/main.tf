resource "null_resource" "galaxy" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = join(" ", [
      "ansible-galaxy",
      "install",
      "-r ${path.module}/requirements.yaml",
      "--force"
    ])
  }
}

resource "local_sensitive_file" "ssh_private_key" {
  content  = var.ssh_private_key
  filename = "${path.module}/ssh-key"
}

resource "local_file" "ssh_signed_public_key" {
  content  = var.ssh_signed_public_key
  filename = "${path.module}/ssh-key-cert.pub"
}

resource "ansible_playbook" "vault_sa" {
  name                    = "playbook"
  playbook                = "${path.module}/playbook.yaml"
  groups                  = ["leader"]
  ignore_playbook_failure = false
  replayable              = true
  extra_vars = {
    ansible_host                 = var.cluster_leader_ip
    ansible_ssh_private_key_file = local_sensitive_file.ssh_private_key.filename
    ansible_ssh_common_args = join(" ", [
      "-o StrictHostKeyChecking=accept-new",
      "-o ControlPath=~/%r@%h:%p",
      "-o UserKnownHostsFile=/dev/null",
      var.ssh_common_args
    ])
    ansible_user                         = var.vm_username
    cluster_vip                          = var.cluster_vip
    vault_sa_namespace                   = var.vault_auth_service_account
    vault_sa_secret                      = var.vault_auth_service_account
    vault_kubernetes_secrets_engine_path = var.vault_kubernetes_secrets_engine_path
  }
}
