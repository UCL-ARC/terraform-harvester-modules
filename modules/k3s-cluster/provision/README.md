<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_ansible"></a> [ansible](#requirement\_ansible) | 1.3.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.5.1 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.2 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.7.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ansible"></a> [ansible](#provider\_ansible) | 1.3.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.1 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.2 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [ansible_playbook.k3s_follower](https://registry.terraform.io/providers/ansible/ansible/1.3.0/docs/resources/playbook) | resource |
| [ansible_playbook.k3s_leader](https://registry.terraform.io/providers/ansible/ansible/1.3.0/docs/resources/playbook) | resource |
| [ansible_playbook.k3s_worker](https://registry.terraform.io/providers/ansible/ansible/1.3.0/docs/resources/playbook) | resource |
| [local_sensitive_file.ssh_key](https://registry.terraform.io/providers/hashicorp/local/2.5.1/docs/resources/sensitive_file) | resource |
| [null_resource.galaxy](https://registry.terraform.io/providers/hashicorp/null/3.2.2/docs/resources/resource) | resource |
| [random_string.token_id](https://registry.terraform.io/providers/hashicorp/random/3.7.2/docs/resources/string) | resource |
| [random_string.token_secret](https://registry.terraform.io/providers/hashicorp/random/3.7.2/docs/resources/string) | resource |
| [local_file.kubeconfig](https://registry.terraform.io/providers/hashicorp/local/2.5.1/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_calico_version"></a> [calico\_version](#input\_calico\_version) | n/a | `any` | n/a | yes |
| <a name="input_cluster_api_vip"></a> [cluster\_api\_vip](#input\_cluster\_api\_vip) | n/a | `any` | n/a | yes |
| <a name="input_cluster_cidr"></a> [cluster\_cidr](#input\_cluster\_cidr) | n/a | `string` | `"192.168.0.0/16"` | no |
| <a name="input_cluster_ingress_vip"></a> [cluster\_ingress\_vip](#input\_cluster\_ingress\_vip) | n/a | `any` | n/a | yes |
| <a name="input_data_dir"></a> [data\_dir](#input\_data\_dir) | n/a | `any` | n/a | yes |
| <a name="input_follower_names"></a> [follower\_names](#input\_follower\_names) | n/a | `any` | n/a | yes |
| <a name="input_ips"></a> [ips](#input\_ips) | n/a | `any` | n/a | yes |
| <a name="input_k3s_extra_install_args_control"></a> [k3s\_extra\_install\_args\_control](#input\_k3s\_extra\_install\_args\_control) | n/a | `any` | n/a | yes |
| <a name="input_k3s_version"></a> [k3s\_version](#input\_k3s\_version) | n/a | `any` | n/a | yes |
| <a name="input_leader_name"></a> [leader\_name](#input\_leader\_name) | n/a | `any` | n/a | yes |
| <a name="input_local_storage_path"></a> [local\_storage\_path](#input\_local\_storage\_path) | n/a | `any` | n/a | yes |
| <a name="input_metallb_version"></a> [metallb\_version](#input\_metallb\_version) | n/a | `any` | n/a | yes |
| <a name="input_openiscsi_version"></a> [openiscsi\_version](#input\_openiscsi\_version) | n/a | `any` | n/a | yes |
| <a name="input_primary_interface"></a> [primary\_interface](#input\_primary\_interface) | n/a | `any` | n/a | yes |
| <a name="input_private_registries"></a> [private\_registries](#input\_private\_registries) | n/a | `any` | n/a | yes |
| <a name="input_ssh_common_args"></a> [ssh\_common\_args](#input\_ssh\_common\_args) | n/a | `any` | n/a | yes |
| <a name="input_ssh_private_key"></a> [ssh\_private\_key](#input\_ssh\_private\_key) | n/a | `any` | n/a | yes |
| <a name="input_vm_username"></a> [vm\_username](#input\_vm\_username) | n/a | `any` | n/a | yes |
| <a name="input_worker_names"></a> [worker\_names](#input\_worker\_names) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kubeconfig"></a> [kubeconfig](#output\_kubeconfig) | n/a |
<!-- END_TF_DOCS -->
