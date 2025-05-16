<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_harvester"></a> [harvester](#requirement\_harvester) | 0.6.6 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.5.1 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_harvester"></a> [harvester](#provider\_harvester) | 0.6.6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [harvester_virtualmachine.vm](https://registry.terraform.io/providers/harvester/harvester/0.6.6/docs/resources/virtualmachine) | resource |
| [harvester_image.vm_image](https://registry.terraform.io/providers/harvester/harvester/0.6.6/docs/data-sources/image) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_disks"></a> [additional\_disks](#input\_additional\_disks) | n/a | <pre>list(object({<br/>    auto_delete = optional(bool, false)<br/>    boot_order = number<br/>    bus        = string<br/>    hot_plug   = optional(bool, false)<br/>    name       = string<br/>    mount      = optional(string, "")<br/>    size       = string<br/>    type       = string<br/>  }))</pre> | `[]` | no |
| <a name="input_cloudinit_type"></a> [cloudinit\_type](#input\_cloudinit\_type) | n/a | `string` | `"noCloud"` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | n/a | `number` | `2` | no |
| <a name="input_disk_auto_delete"></a> [disk\_auto\_delete](#input\_disk\_auto\_delete) | n/a | `bool` | `false` | no |
| <a name="input_disk_boot_order"></a> [disk\_boot\_order](#input\_disk\_boot\_order) | n/a | `number` | `1` | no |
| <a name="input_disk_bus"></a> [disk\_bus](#input\_disk\_bus) | n/a | `string` | `"virtio"` | no |
| <a name="input_disk_name"></a> [disk\_name](#input\_disk\_name) | n/a | `string` | `"rootdisk"` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | n/a | `string` | `"30Gi"` | no |
| <a name="input_disk_type"></a> [disk\_type](#input\_disk\_type) | n/a | `string` | `"disk"` | no |
| <a name="input_efi_boot"></a> [efi\_boot](#input\_efi\_boot) | n/a | `bool` | `false` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | n/a | `string` | `"16Gi"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the vm | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Name of the namespace into which the VMs with be delployed. It must exist | `string` | n/a | yes |
| <a name="input_network_data"></a> [network\_data](#input\_network\_data) | Data for cloud-init to use | `string` | `""` | no |
| <a name="input_networks"></a> [networks](#input\_networks) | Map of harvester VM networks to add NICs for | <pre>list(object({<br/>    network = string<br/>    iface   = string<br/>  }))</pre> | n/a | yes |
| <a name="input_run_strategy"></a> [run\_strategy](#input\_run\_strategy) | n/a | `string` | `"RerunOnFailure"` | no |
| <a name="input_ssh_private_key"></a> [ssh\_private\_key](#input\_ssh\_private\_key) | n/a | `string` | n/a | yes |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | n/a | `string` | `"10m"` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | Data for cloud-init to use | `string` | n/a | yes |
| <a name="input_vm_image"></a> [vm\_image](#input\_vm\_image) | OS image to use | `string` | n/a | yes |
| <a name="input_vm_image_namespace"></a> [vm\_image\_namespace](#input\_vm\_image\_namespace) | OS image namespace to use | `string` | n/a | yes |
| <a name="input_vm_tags"></a> [vm\_tags](#input\_vm\_tags) | n/a | `map(any)` | `{}` | no |
| <a name="input_vm_username"></a> [vm\_username](#input\_vm\_username) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ip"></a> [ip](#output\_ip) | n/a |
<!-- END_TF_DOCS -->
