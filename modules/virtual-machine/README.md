<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_harvester"></a> [harvester](#requirement\_harvester) | >= 1.6.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_harvester"></a> [harvester](#provider\_harvester) | 1.8.1 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [harvester_cloudinit_secret.user_data_secret](https://registry.terraform.io/providers/harvester/harvester/latest/docs/resources/cloudinit_secret) | resource |
| [harvester_virtualmachine.vm](https://registry.terraform.io/providers/harvester/harvester/latest/docs/resources/virtualmachine) | resource |
| [harvester_image.primary_disk](https://registry.terraform.io/providers/harvester/harvester/latest/docs/data-sources/image) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_additional_disks"></a> [additional\_disks](#input\_additional\_disks) | n/a | <pre>list(object({<br/>    auto_delete = optional(bool, true)<br/>    boot_order  = number<br/>    bus         = string<br/>    hot_plug    = optional(bool, false)<br/>    name        = string<br/>    mount       = optional(string, "")<br/>    size        = string<br/>    type        = string<br/>  }))</pre> | `[]` | no |
| <a name="input_cloudinit_type"></a> [cloudinit\_type](#input\_cloudinit\_type) | n/a | `string` | `"noCloud"` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | n/a | `number` | `2` | no |
| <a name="input_efi_boot"></a> [efi\_boot](#input\_efi\_boot) | n/a | `bool` | `false` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | n/a | `string` | `"16Gi"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the vm | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Name of the namespace into which the VMs with be deployed. It must exist | `string` | n/a | yes |
| <a name="input_network_data"></a> [network\_data](#input\_network\_data) | Data for cloud-init to use | `string` | `""` | no |
| <a name="input_networks"></a> [networks](#input\_networks) | Map of harvester VM networks to add NICs for | <pre>list(object({<br/>    cidr    = optional(string, "")<br/>    dns     = optional(string, "")<br/>    gateway = optional(string, "")<br/>    iface   = string<br/>    ip      = optional(string, "")<br/>    network = string<br/>  }))</pre> | n/a | yes |
| <a name="input_primary_disk"></a> [primary\_disk](#input\_primary\_disk) | n/a | <pre>object({<br/>    auto_delete     = optional(bool, true)<br/>    boot_order      = optional(number, 1)<br/>    bus             = optional(string, "virtio")<br/>    image           = optional(string, "")<br/>    image_namespace = optional(string, "")<br/>    name            = optional(string, "rootdisk")<br/>    size            = optional(string, "30Gi")<br/>    type            = optional(string, "disk")<br/>  })</pre> | n/a | yes |
| <a name="input_run_strategy"></a> [run\_strategy](#input\_run\_strategy) | n/a | `string` | `"RerunOnFailure"` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | n/a | `string` | `""` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | n/a | `string` | `"10m"` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | Data for cloud-init to use | `string` | `""` | no |
| <a name="input_vm_description"></a> [vm\_description](#input\_vm\_description) | Description of the VM | `string` | `""` | no |
| <a name="input_vm_tags"></a> [vm\_tags](#input\_vm\_tags) | n/a | `map(any)` | `{}` | no |
| <a name="input_vm_username"></a> [vm\_username](#input\_vm\_username) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_ip"></a> [ip](#output\_ip) | n/a |
<!-- END_TF_DOCS -->
