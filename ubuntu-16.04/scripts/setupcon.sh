#!/bin/bash -eux

# configure German locale and language settings

sed -i -e 's/^CODESET=".*"/CODESET="Uni2"/' -e 's/^CHARMAP=".*"/CHARMAP="UTF-8"/' /etc/default/console-setup
sed -i -e 's/^XKBVARIANT=".*"/XKBVARIANT="nodeadkeys"/' /etc/default/keyboard

locale-gen de_DE
locale-gen de_DE@euro
locale-gen de_DE.UTF-8
update-locale LANG=de_DE.UTF-8 LANGUAGE=de_DE:de:en_US:en
declare -x LANG=de_DE.UTF-8

dpkg-reconfigure -f noninteractive console-setup keyboard-configuration
udevadm trigger --subsystem-match=input --action=change