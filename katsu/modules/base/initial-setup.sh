#!/bin/sh
# Set up initial setup, might be redundant idk
systemctl enable initial-setup
touch /var/lib/gdm/run-initial-setup || true


# Set default target to graphical
systemctl set-default graphical.target

touch /.unconfigured
