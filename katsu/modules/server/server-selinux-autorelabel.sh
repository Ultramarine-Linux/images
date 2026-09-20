#!/bin/sh
set -eu

# The build host cannot assign some Cockpit-specific context types from the
# image policy. Let the installed Server system complete labeling at first boot.
touch /.autorelabel
