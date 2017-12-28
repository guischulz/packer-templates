#!/bin/bash -eux

# install VirtualBox guest additions

mount -o loop,ro ~/VBoxGuestAdditions.iso /mnt/
sh /mnt/VBoxLinuxAdditions.run
umount /mnt/
rm -f ~/VBoxGuestAdditions.iso