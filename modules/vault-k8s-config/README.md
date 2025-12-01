<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_ansible"></a> [ansible](#requirement\_ansible) | 1.3.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.6.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ansible"></a> [ansible](#provider\_ansible) | 1.3.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.3 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [ansible_playbook.vault_sa](https://registry.terraform.io/providers/ansible/ansible/1.3.0/docs/resources/playbook) | resource |
| [local_file.ssh_signed_public_key](https://registry.terraform.io/providers/hashicorp/local/2.6.1/docs/resources/file) | resource |
| [local_sensitive_file.ssh_private_key](https://registry.terraform.io/providers/hashicorp/local/2.6.1/docs/resources/sensitive_file) | resource |
| [null_resource.galaxy](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_leader_ip"></a> [cluster\_leader\_ip](#input\_cluster\_leader\_ip) | IP address of the k3s cluster leader | `string` | n/a | yes |
| <a name="input_cluster_vip"></a> [cluster\_vip](#input\_cluster\_vip) | Cluster VIP for the k3s cluster | `string` | n/a | yes |
| <a name="input_ssh_common_args"></a> [ssh\_common\_args](#input\_ssh\_common\_args) | Common SSH arguments for Ansible | `string` | `""` | no |
| <a name="input_ssh_private_key"></a> [ssh\_private\_key](#input\_ssh\_private\_key) | SSH private key content for accessing the VM | `string` | n/a | yes |
| <a name="input_ssh_signed_public_key"></a> [ssh\_signed\_public\_key](#input\_ssh\_signed\_public\_key) | SSH signed public key content for accessing the VM | `string` | `""` | no |
| <a name="input_vault_auth_service_account"></a> [vault\_auth\_service\_account](#input\_vault\_auth\_service\_account) | Name of the Vault authentication service account | `string` | n/a | yes |
| <a name="input_vault_kubernetes_secrets_engine_path"></a> [vault\_kubernetes\_secrets\_engine\_path](#input\_vault\_kubernetes\_secrets\_engine\_path) | Path to the Kubernetes secrets engine in Vault | `string` | n/a | yes |
| <a name="input_vm_username"></a> [vm\_username](#input\_vm\_username) | Username for the VM | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
