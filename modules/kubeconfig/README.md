<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_ansible"></a> [ansible](#requirement\_ansible) | 1.3.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.5.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ansible"></a> [ansible](#provider\_ansible) | 1.3.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [ansible_playbook.kubeconfig](https://registry.terraform.io/providers/ansible/ansible/1.3.0/docs/resources/playbook) | resource |
| [local_file.ssh_signed_public_key](https://registry.terraform.io/providers/hashicorp/local/2.5.3/docs/resources/file) | resource |
| [local_sensitive_file.ssh_private_key](https://registry.terraform.io/providers/hashicorp/local/2.5.3/docs/resources/sensitive_file) | resource |
| [local_file.kubeconfig](https://registry.terraform.io/providers/hashicorp/local/2.5.3/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_vip"></a> [cluster\_vip](#input\_cluster\_vip) | KubeVip virtual IP address | `string` | n/a | yes |
| <a name="input_ssh_common_args"></a> [ssh\_common\_args](#input\_ssh\_common\_args) | n/a | `string` | `""` | no |
| <a name="input_ssh_private_key"></a> [ssh\_private\_key](#input\_ssh\_private\_key) | Path to the SSH private key to use for the VMs | `string` | n/a | yes |
| <a name="input_ssh_signed_public_key"></a> [ssh\_signed\_public\_key](#input\_ssh\_signed\_public\_key) | SSH signed public key content for accessing the VM | `string` | `""` | no |
| <a name="input_vm_ip"></a> [vm\_ip](#input\_vm\_ip) | IP address of the VM | `string` | n/a | yes |
| <a name="input_vm_username"></a> [vm\_username](#input\_vm\_username) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kubeconfig"></a> [kubeconfig](#output\_kubeconfig) | n/a |
<!-- END_TF_DOCS -->
