<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_ansible"></a> [ansible](#requirement\_ansible) | 1.3.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.7.2 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_k3s_server_vm"></a> [k3s\_server\_vm](#module\_k3s\_server\_vm) | ../virtual-machine | n/a |

## Resources

| Name | Type |
|------|------|
| [random_string.crypto_key](https://registry.terraform.io/providers/hashicorp/random/3.7.2/docs/resources/string) | resource |
| [random_string.dht_key](https://registry.terraform.io/providers/hashicorp/random/3.7.2/docs/resources/string) | resource |
| [random_string.mdns](https://registry.terraform.io/providers/hashicorp/random/3.7.2/docs/resources/string) | resource |
| [random_string.rendezvous](https://registry.terraform.io/providers/hashicorp/random/3.7.2/docs/resources/string) | resource |
| [random_string.room](https://registry.terraform.io/providers/hashicorp/random/3.7.2/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_bundles"></a> [additional\_bundles](#input\_additional\_bundles) | List of additional kairos community bundles to install in the cluster | <pre>list(object({<br/>    target = string<br/>    values = optional(map(any))<br/>  }))</pre> | `[]` | no |
| <a name="input_additional_disks"></a> [additional\_disks](#input\_additional\_disks) | n/a | <pre>list(object({<br/>    boot_order = number<br/>    bus        = string<br/>    name       = string<br/>    mount      = string<br/>    size       = string<br/>    type       = string<br/>  }))</pre> | `[]` | no |
| <a name="input_additional_manifests"></a> [additional\_manifests](#input\_additional\_manifests) | Additional manifests for k3s to deploy on startup, written to /var/lib/rancher/k3s/server/manifests/{name}.yaml | <pre>list(object({<br/>    content = string<br/>    name    = string<br/>  }))</pre> | `[]` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the cluster used to uniqify the vm names | `string` | n/a | yes |
| <a name="input_cluster_namespace"></a> [cluster\_namespace](#input\_cluster\_namespace) | Name of the namespace into which the VMs with be delployed. It must exist | `string` | n/a | yes |
| <a name="input_cluster_vip"></a> [cluster\_vip](#input\_cluster\_vip) | KubeVip virtual IP address | `string` | n/a | yes |
| <a name="input_control_nodes"></a> [control\_nodes](#input\_control\_nodes) | Number of control plane nodes to deploy | `number` | `3` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | n/a | `number` | `4` | no |
| <a name="input_efi_boot"></a> [efi\_boot](#input\_efi\_boot) | n/a | `bool` | `false` | no |
| <a name="input_iso_disk_image"></a> [iso\_disk\_image](#input\_iso\_disk\_image) | OS image to use | `string` | n/a | yes |
| <a name="input_iso_disk_image_namespace"></a> [iso\_disk\_image\_namespace](#input\_iso\_disk\_image\_namespace) | OS image  namespace to use | `string` | n/a | yes |
| <a name="input_iso_disk_name"></a> [iso\_disk\_name](#input\_iso\_disk\_name) | n/a | `string` | `"iso-cdrom"` | no |
| <a name="input_iso_disk_size"></a> [iso\_disk\_size](#input\_iso\_disk\_size) | n/a | `string` | `"30Gi"` | no |
| <a name="input_k3s_extra_args"></a> [k3s\_extra\_args](#input\_k3s\_extra\_args) | Extra arguments to pass to k3s | `list(string)` | `[]` | no |
| <a name="input_k3s_oidc_admin_binding_name"></a> [k3s\_oidc\_admin\_binding\_name](#input\_k3s\_oidc\_admin\_binding\_name) | OIDC admin binding name to use for the cluster | `string` | `"cluster-admin"` | no |
| <a name="input_k3s_oidc_admin_group"></a> [k3s\_oidc\_admin\_group](#input\_k3s\_oidc\_admin\_group) | OIDC admin group to use for the cluster | `string` | `""` | no |
| <a name="input_k3s_oidc_args"></a> [k3s\_oidc\_args](#input\_k3s\_oidc\_args) | Extra arguments to pass to k3s | `list(string)` | `[]` | no |
| <a name="input_kairos_bind_mounts"></a> [kairos\_bind\_mounts](#input\_kairos\_bind\_mounts) | List paths to make persistent on the hosts. | `list(string)` | `[]` | no |
| <a name="input_kairos_operator_version"></a> [kairos\_operator\_version](#input\_kairos\_operator\_version) | Version of the kairos operator to install in the cluster. | `string` | `"v0.0.3"` | no |
| <a name="input_kubevip_manage_services"></a> [kubevip\_manage\_services](#input\_kubevip\_manage\_services) | Use kubevip to manage Loadbalancer IP address assignment | `bool` | `false` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | n/a | `string` | `"32Gi"` | no |
| <a name="input_networks"></a> [networks](#input\_networks) | Map of harvester VM networks to add NICs for. Key should be interface name. | <pre>map(object({<br/>    alias   = string<br/>    ips     = optional(list(string), [])<br/>    cidr    = number<br/>    gateway = string<br/>    dns     = string<br/>    network = string<br/>  }))</pre> | n/a | yes |
| <a name="input_primary_interface"></a> [primary\_interface](#input\_primary\_interface) | Name of the primary network interface | `string` | `"eth0"` | no |
| <a name="input_private_registries"></a> [private\_registries](#input\_private\_registries) | List of private container image registries to use in the cluster | `list(map(string))` | `[]` | no |
| <a name="input_root_disk_container_image"></a> [root\_disk\_container\_image](#input\_root\_disk\_container\_image) | n/a | `string` | `""` | no |
| <a name="input_root_disk_size"></a> [root\_disk\_size](#input\_root\_disk\_size) | n/a | `string` | `"30Gi"` | no |
| <a name="input_ssh_admin_principals"></a> [ssh\_admin\_principals](#input\_ssh\_admin\_principals) | List of SSH principals to use for the VMs | `list(string)` | `[]` | no |
| <a name="input_ssh_ca_public_key"></a> [ssh\_ca\_public\_key](#input\_ssh\_ca\_public\_key) | SSH CA public key to use for the VMs | `string` | `""` | no |
| <a name="input_ssh_common_args"></a> [ssh\_common\_args](#input\_ssh\_common\_args) | n/a | `string` | `""` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | SSH public key to use for the VMs | `string` | `""` | no |
| <a name="input_suc_version"></a> [suc\_version](#input\_suc\_version) | Version of the system-upgrade-controller to install in the cluster. | `string` | `"v0.16.3"` | no |
| <a name="input_vault_auth_service_account"></a> [vault\_auth\_service\_account](#input\_vault\_auth\_service\_account) | Service account to use for the vault auth | `string` | `"vault-auth"` | no |
| <a name="input_vault_auto_ca"></a> [vault\_auto\_ca](#input\_vault\_auto\_ca) | n/a | `map(any)` | <pre>{<br/>  "default_ca": "",<br/>  "enabled": false,<br/>  "krl_url": "",<br/>  "vault_addr": "",<br/>  "vault_ssh_mount_path": ""<br/>}</pre> | no |
| <a name="input_vm_tags"></a> [vm\_tags](#input\_vm\_tags) | n/a | `map(any)` | n/a | yes |
| <a name="input_vm_username"></a> [vm\_username](#input\_vm\_username) | n/a | `string` | n/a | yes |
| <a name="input_worker_nodes"></a> [worker\_nodes](#input\_worker\_nodes) | Number of worker nodes to deploy | `number` | `0` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ips"></a> [ips](#output\_ips) | n/a |
| <a name="output_leader_ip"></a> [leader\_ip](#output\_leader\_ip) | n/a |
<!-- END_TF_DOCS -->
