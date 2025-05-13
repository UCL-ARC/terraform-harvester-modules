output "leader_ip" {
  value = module.k3s_server_vm[0].ip
}

output "ips" {
  value = module.k3s_server_vm.*.ip
}
