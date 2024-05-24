#!/bin/bash -x
# Set up initial setup, might be redundant idk
if rpm -q gnome-initial-setup; then
    mkdir -p /var/lib/gdm
    touch /var/lib/gdm/run-initial-setup
else 
    systemctl enable initial-setup || true
fi

# Set default target to graphical
systemctl set-default graphical.target
