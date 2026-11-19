output "ssh_private_key" {
  value     = tls_private_key.ssh.private_key_openssh
  sensitive = true
}

output "kubeconfig" {
  value     = module.install_k3s.kubeconfig
  sensitive = true
}

output "leader_ip" {
  value = module.k3s_server_vm[0].ip
}

output "ips" {
  value = module.k3s_server_vm.*.ip
}

output "cluster_name" {
  value = var.cluster_name
}

output "api_vip" {
  value = var.cluster_api_vip
}

output "vm_names" {
  value = local.vm_names
}

output "vm_username" {
  value = var.vm_username
}
