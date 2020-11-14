# packer-templates

[Packer](https://www.packer.io/) templates

## Usage

Clone the repository:

    git clone https://github.com/guischulz/packer-templates

Change working directory to template sub-directory:

    cd packer-templates\ubuntu-20.04

Build a machine image from the template in the repository:

    packer build ubuntu-20.04.1-server-amd64.json

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

Build an Ubuntu 20.04 server image with a 10 GB hard disk, 2 GB memory and 1 CPU using the VirtualBox provider:

    packer build -only=virtualbox-iso -var disk_size=10000 -var memory=2048 -var cpus=1 ubuntu-20.04.1-server-amd64.json

**Know Problem**: On Windows platform `packer` sometimes fails to halt and deregister the VirtualBox VM.

    ==> virtualbox-iso: Error detaching ISO: VBoxManage error: VBoxManage.exe: error: Failed to get a console object from the direct session (VBOX_E_INVALID_OBJECT_STATE)
    ==> virtualbox-iso: VBoxManage.exe: error: Details: code VBOX_E_VM_ERROR (0x80bb0003), component MachineWrap, interface IMachine, callee IUnknown
    ==> virtualbox-iso: VBoxManage.exe: error: Context: "LockMachine(a->session, LockType_Shared)" at line 336 of file VBoxManageStorageController.cpp

**Workaround**: Add option `post_shutdown_delay` to your `packer` command line arguments, e.g.

    packer build -var post_shutdown_delay=2m ubuntu-20.04.1-server-amd64.json
