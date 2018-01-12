#!/bin/bash -eux

# Clean apt packages and install scripts
apt-get clean -y

# Remove orphaned packages no longer needed
apt-get autoremove --purge

# Remove apt package list files
find /var/lib/apt/lists -type f | xargs rm -f

# Remove bash history
unset HISTFILE
rm -f ~/.bash_history

# Remove temporary files
rm -rf ~/.cache
rm -rf /tmp/*
rm -rf /var/tmp/*

## Clear some logs
LOGS_TO_CLEAR="auth.log boot.log btmp faillog kern.log lastlog syslog wtmp"
for f in $LOGS_TO_CLEAR; do
  truncate -s 0 /var/log/$f
done

# Zero root partition
count=`df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}'`;
count=$((count -= 1))
dd if=/dev/zero of=/ZERO bs=1024 count=$count;
sync
rm -f /ZERO;

# Zero /boot partition
count=`df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}'`;
count=$((count -= 1))
dd if=/dev/zero of=/boot/ZERO bs=1024 count=$count;
sync
rm -f /boot/ZERO;

# Zero swap partition
swappart=`cat /proc/swaps | tail -n1 | awk -F ' ' '{print $1}'`
swapoff $swappart;
dd if=/dev/zero of=$swappart;
sync
mkswap $swappart;
swapon $swappart;
sync
