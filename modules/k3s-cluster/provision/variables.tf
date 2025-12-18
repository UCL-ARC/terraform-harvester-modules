variable "calico_version" {}

variable "cluster_cidr" {
  type    = string
  default = "192.168.0.0/16"
}

variable "cluster_api_vip" {}

variable "cluster_additional_vips" {}

variable "data_dir" {}

variable "ips" {}

variable "k3s_version" {}

variable "k3s_extra_install_args_control" {}

variable "leader_name" {}

variable "follower_names" {}

variable "local_storage_path" {}

variable "metallb_version" {}

variable "openiscsi_version" {}

variable "primary_interface" {}

variable "private_registries" {}

variable "ssh_common_args" {}

variable "ssh_private_key" {}

variable "vm_username" {}

variable "worker_names" {}
