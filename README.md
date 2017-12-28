packer-templates
================

[Packer](https://www.packer.io/) templates

Usage
-----

Clone the repository:

    git clone https://github.com/guischulz/packer-templates

Change working directory to template sub-directory:

    cd packer-templates\ubuntu-16.04

Build a machine image from the template in the repository:

    packer build ubuntu-16.04.03-server-amd64.json


Configuration
-------------

You can configure each template to match your requirements by setting the following [template user variables](https://packer.io/docs/templates/user-variables.html).

 User Variable       | Default Value | Description
---------------------|---------------|-------------------------------------------------------------------------------
 `cpus`              | 4             | Number of CPUs
 `disk_size`         | 100000        | [Documentation](https://packer.io/docs/builders/virtualbox-iso.html#disk_size)
 `headless`          | 0             | [Documentation](https://packer.io/docs/builders/virtualbox-iso.html#headless)
 `memory`            | 8192          | Memory size in MB
 `mirror`            | `file://...`  | A URL of the mirror where the ISO image is available

By default the VirtualBox provider will setup a NAT network with port forwarding for HTTP and SSH.

Name   | Protocol | Host-Port | Guest-Port
-------|----------|-----------|-----------
apache | TCP      | 80        | 80
ssh    | TCP      | 2222      | 22

### Example

Build an Ubuntu 16.04 server image with a 40 GB hard disk, 2 GB memory and 1 CPU from a mirror using the VirtualBox provider:

    packer build -only=virtualbox-iso -var disk_size=40000 -var memory=2048 -var cpus=1 -var mirror="http://de.releases.ubuntu.com/xenial" ubuntu-16.04.03-server-amd64.json

**Know Problem**: On a Windows platform `packer` may fail to copy the VirtualBox Guest additions, see [issue \#5628](https://github.com/hashicorp/packer/issues/5628)
```
==> virtualbox-iso: Downloading or copying Guest additions
    virtualbox-iso: Downloading or copying: file://C:/Program%20Files/Oracle/VirtualBox/VBoxGuestAdditions.iso
    virtualbox-iso: Error downloading: CreateFile /Program Files/Oracle/VirtualBox/VBoxGuestAdditions.iso: The system can not find the path specified.
==> virtualbox-iso: Guest additions download failed.
Build 'virtualbox-iso' errored: Guest additions download failed.
```

**Workaround**: Run `packer` on the same drive where the Guest addition ISO is located, here `C:\`.
