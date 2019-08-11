# packer-templates

[Packer](https://www.packer.io/) templates

## Usage

Clone the repository:

    git clone https://github.com/guischulz/packer-templates

Change working directory to template sub-directory:

    cd packer-templates\ubuntu-18.04

Build a machine image from the template in the repository:

    packer build ubuntu-18.04.3-server-amd64.json

## Configuration

You can configure each template to match your requirements by setting the following [template user variables](https://packer.io/docs/templates/user-variables.html).

 User Variable       | Default Value | Description
---------------------|---------------|-------------------------------------------------------------------------------
 `cpus`              | 4             | Number of CPUs
 `disk_size`         | 100000        | [Documentation](https://packer.io/docs/builders/virtualbox-iso.html#disk_size)
 `headless`          | true          | [Documentation](https://packer.io/docs/builders/virtualbox-iso.html#headless)
 `memory`            | 8192          | Memory size in MB
 `mirror`            | `file://...`  | A URL of the mirror where the ISO image is available

By default the VirtualBox provider will setup a NAT network with port forwarding for HTTP and SSH.

Name   | Protocol | Host-Port | Guest-Port
-------|----------|-----------|-----------
apache | TCP      | 80        | 80
ssh    | TCP      | 22        | 22

### Example

Build an Ubuntu 18.04 server image with a 10 GB hard disk, 2 GB memory and 1 CPU using the VirtualBox provider:

    packer build -only=virtualbox-iso -var disk_size=10000 -var memory=2048 -var cpus=1 -var mirror="http://cdimage.ubuntu.com/releases/18.04/release" ubuntu-18.04.3-server-amd64.json
