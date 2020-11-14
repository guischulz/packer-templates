#!/bin/bash -eux

# Install VirtualBox guest additions
mount -o ro ~/VBoxGuestAdditions.iso /mnt/
sh /mnt/VBoxLinuxAdditions.run --nox11
umount /mnt/

# Sign VirtualBox kernel modules
KEY_DIR=/root/module-signing
KEY_NAME=vbox
MODS_TO_SIGN="vboxguest vboxsf vboxvideo"

if [ ! -d $KEY_DIR ]; then
  mkdir -p $KEY_DIR
fi

if [ ! -f $KEY_DIR/$KEY_NAME.key ]; then
  openssl rand -writerand ~/.rnd
  openssl req -new -x509 -newkey rsa:2048 -keyout $KEY_DIR/$KEY_NAME.key -outform DER -out $KEY_DIR/$KEY_NAME.der -nodes -days 36500 -subj "/CN=VirtualBox/"
  chmod 600 $KEY_DIR/$KEY_NAME.key
fi

for f in $MODS_TO_SIGN; do
    /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 $KEY_DIR/$KEY_NAME.key $KEY_DIR/$KEY_NAME.der $(modinfo -n $f)
done

# Add current user to group vboxsf
adduser $(logname) vboxsf

# Cleanup
rm -rf ~/.cache
rm -f ~/.rnd
rm -f ~/VBoxGuestAdditions.iso
rm -f /var/log/vbox*.log

## Clear some logs
LOGS_TO_CLEAR="auth.log boot.log btmp faillog kern.log lastlog syslog wtmp"
for f in $LOGS_TO_CLEAR; do
  truncate -s 0 /var/log/$f
done
