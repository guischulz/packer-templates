#!/bin/bash -eux

# Add 'ubuntu' account to allowed sudo users without passwd

echo -e 'ubuntu\tALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/ubuntu
chmod 0440 /etc/sudoers.d/ubuntu