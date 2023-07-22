#!/bin/bash -x
RELEASEVER=38
# Test rootfs build

sudo dnf5 install @core grub2-efi-ia32-cdboot grub2-pc-modules grub2-pc grub2-efi-cdboot shim --releasever=${RELEASEVER} --installroot=$PWD/root/ --use-host-config

# use grub-mkrescue or something to make an iso