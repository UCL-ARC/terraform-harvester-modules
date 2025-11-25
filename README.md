# terraform-harvester-modules

Terraform modules for deploying virtual machines and [k3s](https://k3s.io/)
clusters on Harvester.

## virtual-machine module

The `virtual-machine` module allows you to create and manage virtual machines on
Harvester. To deploy a basic VM with a single boot disk and an IP provided by
DHCP:

```hcl
module "vm" {
  source = "github.com/UCL-ARC/terraform-harvester-modules//modules/virtual-machine"

  cpu       = 2
  efi_boot  = true
  memory    = "8Gi"
  name      = "my-vm"
  namespace = "default"
  networks = [
    {
      iface   = "nic-1"
      network = "default/net"
    }
  ]
  vm_image           = "almalinux-9.5"
  vm_image_namespace = "harvester-public"
  vm_username        = "almalinux"
}
```

To deploy a VM with a data disk in addition to the boot disk, a static IP
address and an SSH key:

```hcl
  source = "github.com/UCL-ARC/terraform-harvester-modules//modules/virtual-machine"

  additional_disks = [
    {
      boot_order = 2
      bus        = "virtio"
      name       = "data"
      mount      = "/data"
      size       = "100Gi"
      type       = "disk"
    }
  ]
  cpu              = 2
  efi_boot         = true
  memory           = "8Gi"
  name             = "my-vm"
  namespace        = "default"
  networks = [
    {
      cidr    = 24
      dns     = "10.0.0.1"
      gateway = "10.0.0.1"
      iface   = "nic-1"
      ip      = "10.0.0.2"
      network = "default/net"
    }
  ]
  ssh_public_key     = file("~/.ssh/id_rsa")
  vm_image           = "almalinux-9.5"
  vm_image_namespace = "harvester-public"
  vm_username        = "almalinux"
```

It is also possible to completely customise the `cloud-config` data by providing
your own files via the `network_data` and `user_data` variables.

Note that the IP addresses and namespaces given here are illustrative only and
should be changed.

## k3s-cluster Module

The `k3s-cluster` module helps you deploy a high-availability
[k3s](https://k3s.io/) Kubernetes cluster on Harvester. This module internally
uses the `virtual-machine` module to create the necessary VMs. This module
provides `user_data` to the virtual machines, and is configured to install k3s
using the default operating system user in the machine image being used (set
using the `vm_image` variable). As such the `vm_username` variable must be set
accordingly (e.g. `cloud-user` for a RHEL machine image).

Example usage which would deploy a 3-node cluster:

```hcl
module "k3s_cluster" {
  source = "github.com/UCL-ARC/terraform-harvester-modules//modules/k3s-cluster"

  cluster_name        = "my-cluster"
  cluster_api_vip     = "10.0.0.5"
  cluster_ingress_vip = "10.0.0.6"
  namespace           = "default"
  networks = {
    eth0 = {
      ips     = ["10.0.0.2", "10.0.0.3", "10.0.0.4"]
      cidr    = 24
      gateway = "10.0.0.1"
      dns     = "10.0.0.1"
      network = "default/net"
    }
  }
  vm_image           = "rhel-9.4"
  vm_image_namespace = "default"
  vm_username        = "cloud-user"
}
```

## kairos-k3s-cluster module

The `kairos-k3s-cluster` module helps you deploy a high-availability
[k3s](https://k3s.io/) Kubernetes cluster on Harvester with virtual machines
deployed using an immutable operating system. [kairos](https://kairos.io/)
provides a means to turn a Linux system, and preferred Kubernetes distribution,
into a secure bootable image. Here users of the module can specify both the
kairos ISO and container image to be deployed, forming the final OS running in
the VMs. Although this supports multiple different Kubernetes distributions we
strongly encourage the use of k3s. In the example below the kairos Alpine ISO is
used to deploy a Rocky Linux container image which has k3s baked in. The
[kairos-operator](https://github.com/kairos-io/kairos-operator) is installed in
the cluster to provide a means to manage OS and Kubernetes distribution upgrades
in a zero-downtime manner. Either a `NodeOp` or `NodeOpUpgrade` resource needs
to be provided by the consumer of the module to trigger the upgrade process.

### k3s arguments

Arguments to be passed to the `k3s` server can be provided using the `k3s_args`
variable. This allows users of the module to disable default components such as
`traefik` and `servicelb`, or to configure a different CNI plugin. See the [k3s
documentation](https://docs.k3s.io/installation/configuration) for a full list
of available options. Note that `k3s_args` defaults to disabling `traefik` and
`servicelb`:

```hcl
  k3s_args = [
    "--disable=traefik,servicelb",
  ]
```

OIDC authentication can be configured through the `k3s_oidc_args` variable. This
should contain the necessary arguments to configure OIDC authentication for the
cluster. The `k3s_oidc_admin_group` variable should also be set to the name of
the group in the OIDC provider that should be granted admin privileges on the
cluster. The options set in the `k3s_oidc_args` list is merged with the
`k3s_args` list and passed to the `k3s` block in the `cloud-config` user data.
For example to use an app registration in Azure AD as the OIDC provider, you
would set:

```hcl
  k3s_oidc_args = [
    "--kube-apiserver-arg=oidc-issuer-url=https://login.microsoftonline.com/<tenant-id>/v2.0",
    "--kube-apiserver-arg=oidc-client-id=<app-registration-client-id>",
    "--kube-apiserver-arg=oidc-username-claim=email",
    "--kube-apiserver-arg=oidc-groups-claim=groups",
    "--kube-apiserver-arg=oidc-groups-prefix='odic:'",
    "--kube-apiserver-arg=oidc-username-prefix='odic:'",
  ]
```

### Networking

Here [edgevpn](https://github.com/mudler/edgevpn/tree/master) and
[kubevip](https://kube-vip.io/) configures a peer-to-peer mesh and a virtual IP
address for the cluster (instead of [metallb](https://metallb.io/) which is used
in the `k3s-cluster` module). Note that `k3s` uses
[Flannel](https://github.com/flannel-io/flannel) as the default CNI plugin, and
this is what is used in the module. If you would like to use a different CNI
plugin, or something that provides a means for managing network policies (such
as [Calico](https://www.tigera.io/project-calico/)), then you will need to
deploy this yourself after the cluster is up and running. The `k3s` arguments
that are required can be set using the `k3s_args` variable. For example, to be
able to use Calico as the CNI plugin, you would set:

```hcl
  k3s_args = [
    "--disable=traefik,servicelb", # this is the default
    "--disable-network-policy",
    "--flannel-backend=none",
  ]
```

Note that when disabling the default CNI plugin, `k3s` can take a while to start
as such you should make sure that the service is available before attempting to
install any custom CNI plugin.

### SSH

This module supports the use of certificate-based authentication for SSH. To
enable this, the consumer of the module must provide a CA certificate, and if
required the authorised principles via the `ssh_admin_principals` variable.

```hcl
module "cluster" {
  source = "github.com/UCL-ARC/terraform-harvester-modules//modules/kairos-k3s-cluster"

  cluster_name             = "my-cluster"
  cluster_namespace        = "default"
  cluster_vip              = "10.0.0.5"
  efi_boot                 = true
  iso_disk_image           = "kairos-alpine"
  iso_disk_image_namespace = "default"
  iso_disk_name            = "bootstrap"
  iso_disk_size            = "10Gi"
  networks = {
    eth0 = {
      alias   = "enp1s0"
      ips     = ["10.0.0.2", "10.0.0.3", "10.0.0.4"]
      cidr    = 24
      gateway = "10.0.0.1"
      dns     = "10.0.0.1"
      network = "default/net"
    }
  }
  root_disk_container_image = "docker:quay.io/kairos/rockylinux:9-standard-amd64-generic-v3.4.2-k3sv1.32.3-k3s1"
  ssh_public_key            = file("${path.root}/ssh-key.pub")
  vm_username               = "kairos"
  vm_tags = {
      ssh-user = "kairos"
  }
}
```

### k8s manifests

Additional manifests to be deployed when creating the cluster can be passed to
the module using the `additional_manifests` variable:

```hcl
  additional_manifests = [{
    name = "upgrade-plan"
    content = templatefile("${path.root}/templates/upgrade-plan.yaml.tftpl", {
      image: "9-standard-amd64-generic-v3.4.2-k3sv1.32.3-k3s1"
      version: latest
    })
  }]
```

The example shows how a user of the module might create a template manifest and
and pass the rendered result as a manifest for the `kairos-k3s-module` to use.
The manifest will get written to `/var/lib/rancher/k3s/server/manifests/` and be
applied automatically after the cluster is created.

Manifests can also be passed to the cluster using [Kairos
bundles](https://kairos.io/docs/advanced/bundles/). These are container images
that can be applied on first boot, before Kubernetes starts, to provide a way to
customise the cluster (i.e. deployed manifests or Helm charts). Several popular
Kubernetes tools are provided by the [Kairos community
bundles](https://github.com/kairos-io/community-bundles/tree/main) repository.
The
[system-upgrade-controller](https://github.com/rancher/system-upgrade-controller)
is installed to the cluster using this mechanism. To add more bundles to the
cluster, you can use the `additional_bundles` variable:

```hcl
  additional_bundles = [
    {
      target = "quay.io/kairos/community-bundles/nginx_latest"
      values = {
        nginx = {
          version = "4.12.3"
        }
      }
    }
  ]
```

## kubeconfig module

This module can be used to fetch the kubeconfig file for a k3s cluster deployed
using the `k3s-cluster` or `kairos-k3s-cluster` modules. It uses the
`ansible_playbook` resource from the [Terraform Ansible
Provider](https://registry.terraform.io/providers/ansible/ansible/latest) to SSH
into a k3s nodes and retrieve the kubeconfig file. The `kubeconfig` module
requires a SSH private key and as such the consumer of the module should ensure
that either the public key is present on the node or that a new public key has
been signed by the CA certificate present on the node.

```hcl
resource "tls_private_key" "ssh" {
  algorithm = "ED25519"
}

resource "local_sensitive_file" "ssh_key" {
  filename = "${path.root}/ssh-key"
  content  = tls_private_key.ssh.private_key_openssh
}

module "kubeconfig" {
  depends_on = [ module.cluster ]
  source = "../modules/kubeconfig"

  cluster_vip          = "10.0.0.5"
  ssh_private_key_path = local_sensitive_file.ssh_key.filename # make sure the public key is present on the node
  ssh_common_args = join(" ", [
    "-o ProxyCommand=\"ssh -W %h:%p jumphost\"",
  ])
  vm_ip       = "10.0.0.2"
  vm_username = "kairos"
}
```

For detailed information about each module's variables and outputs, please refer
to the README files in their respective directories:

- [virtual-machine Module Documentation](modules/virtual-machine/README.md)
- [k3s-cluster Module Documentation](modules/k3s-cluster/README.md)
- [kairos-k3s-cluster Module Documentation](modules/kairos-k3s-cluster/)
- [kubeconfig Module Documentation](modules/kubeconfig/README.md)
