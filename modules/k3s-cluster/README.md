<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.7.2 |
| <a name="requirement_remote"></a> [remote](#requirement\_remote) | 0.1.3 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.5 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_install_k3s"></a> [install\_k3s](#module\_install\_k3s) | ./provision | n/a |
| <a name="module_k3s_server_vm"></a> [k3s\_server\_vm](#module\_k3s\_server\_vm) | ../virtual-machine | n/a |

## Resources

| Name | Type |
|------|------|
| [tls_private_key.ssh](https://registry.terraform.io/providers/hashicorp/tls/4.1.0/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_disks"></a> [additional\_disks](#input\_additional\_disks) | n/a | <pre>list(object({<br/>    boot_order = number<br/>    bus        = string<br/>    name       = string<br/>    mount      = string<br/>    size       = string<br/>    type       = string<br/>  }))</pre> | `[]` | no |
| <a name="input_appstream_repo_url"></a> [appstream\_repo\_url](#input\_appstream\_repo\_url) | URL to use to obtain AppStream repository for yum/dnf | `string` | `""` | no |
| <a name="input_baseos_repo_url"></a> [baseos\_repo\_url](#input\_baseos\_repo\_url) | URL to use to obtain BaseOS repository for yum/dnf | `string` | `""` | no |
| <a name="input_calico_version"></a> [calico\_version](#input\_calico\_version) | Version of Calico to install. See: https://github.com/projectcalico/calico/releases | `string` | `"v3.28.1"` | no |
| <a name="input_cluster_api_vip"></a> [cluster\_api\_vip](#input\_cluster\_api\_vip) | MetalLB Virtual IP address to assign for the API server | `string` | n/a | yes |
| <a name="input_cluster_ingress_vip"></a> [cluster\_ingress\_vip](#input\_cluster\_ingress\_vip) | MetalLB Virtual IP address to assign for the Ingress controller | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the cluster used to uniqify the vm names | `string` | n/a | yes |
| <a name="input_control_nodes"></a> [control\_nodes](#input\_control\_nodes) | Number of control plane nodes to deploy | `number` | n/a | yes |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | n/a | `number` | `4` | no |
| <a name="input_data_dir"></a> [data\_dir](#input\_data\_dir) | n/a | `string` | `"/var/lib/rancher/k3s"` | no |
| <a name="input_efi_boot"></a> [efi\_boot](#input\_efi\_boot) | n/a | `bool` | `false` | no |
| <a name="input_k3s_extra_install_args_control"></a> [k3s\_extra\_install\_args\_control](#input\_k3s\_extra\_install\_args\_control) | a list of additional args to be added to the k3s install command on control nodes | `list(string)` | `[]` | no |
| <a name="input_k3s_version"></a> [k3s\_version](#input\_k3s\_version) | Version of k3s to install on Harvester VMs. See: https://github.com/k3s-io/k3s/releases | `string` | `"v1.30.2+k3s1"` | no |
| <a name="input_local_storage_path"></a> [local\_storage\_path](#input\_local\_storage\_path) | Path to use for local storage on Harvester VMs | `string` | `"/var/lib/rancher/k3s/storage"` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | n/a | `string` | `"32Gi"` | no |
| <a name="input_metallb_version"></a> [metallb\_version](#input\_metallb\_version) | Version of metallb to install on Harvester VMs. | `string` | `"v0.14.8"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Name of the namespace into which the VMs with be delployed. It must exist | `string` | n/a | yes |
| <a name="input_networks"></a> [networks](#input\_networks) | Map of harvester VM networks to add NICs for. Key should be interface name. | <pre>map(object({<br/>    ips     = optional(list(string), [])<br/>    cidr    = number<br/>    gateway = string<br/>    dns     = string<br/>    network = string<br/>  }))</pre> | n/a | yes |
| <a name="input_openiscsi_version"></a> [openiscsi\_version](#input\_openiscsi\_version) | Version of openiscsi to install on Harvester VMs. | `string` | `""` | no |
| <a name="input_primary_interface"></a> [primary\_interface](#input\_primary\_interface) | Name of the primary network interface | `string` | `"eth0"` | no |
| <a name="input_private_registries"></a> [private\_registries](#input\_private\_registries) | List of private container image registries to use in the cluster | `list(map(string))` | `[]` | no |
| <a name="input_root_disk_size"></a> [root\_disk\_size](#input\_root\_disk\_size) | n/a | `string` | `"30Gi"` | no |
| <a name="input_run_strategy"></a> [run\_strategy](#input\_run\_strategy) | n/a | `string` | `"RerunOnFailure"` | no |
| <a name="input_ssh_common_args"></a> [ssh\_common\_args](#input\_ssh\_common\_args) | n/a | `string` | `""` | no |
| <a name="input_vm_count"></a> [vm\_count](#input\_vm\_count) | How many VMs to create | `number` | `3` | no |
| <a name="input_vm_image"></a> [vm\_image](#input\_vm\_image) | OS image to use | `string` | n/a | yes |
| <a name="input_vm_image_namespace"></a> [vm\_image\_namespace](#input\_vm\_image\_namespace) | OS image  namespace to use | `string` | n/a | yes |
| <a name="input_vm_tags"></a> [vm\_tags](#input\_vm\_tags) | n/a | `map(any)` | n/a | yes |
| <a name="input_vm_username"></a> [vm\_username](#input\_vm\_username) | n/a | `string` | n/a | yes |
| <a name="input_worker_nodes"></a> [worker\_nodes](#input\_worker\_nodes) | Number of worker nodes to deploy | `number` | `0` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ips"></a> [ips](#output\_ips) | n/a |
| <a name="output_kubeconfig"></a> [kubeconfig](#output\_kubeconfig) | n/a |
| <a name="output_leader_ip"></a> [leader\_ip](#output\_leader\_ip) | n/a |
| <a name="output_ssh_private_key"></a> [ssh\_private\_key](#output\_ssh\_private\_key) | n/a |
<!-- END_TF_DOCS -->
