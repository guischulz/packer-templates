#!/bin/bash -eux

# install security updates

declare -x DEBIAN_FRONTEND="noninteractive"

apt-get update
apt-get -yq install update-notifier-common unattended-upgrades
unattended-upgrade

systemctl stop sshd.service
systemctl reboot
sleep 60s