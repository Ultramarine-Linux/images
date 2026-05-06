#!/bin/bash
# Runs inside the chroot during postprocessing.
# Expected environment variables:
#   LOOP         - loop device path (e.g. /dev/loop0)
#   ARCHITECTURE - target architecture (e.g. x86-64)

set -euxo pipefail

if [[ "$ARCHITECTURE" == "x86-64" ]]; then
    # GRUB's blessing onto this beautiful disk!
    grub2-install --target=i386-pc "$LOOP"
fi

kernelinstall_cleanup() {
    mv /tmp/dracut.install /usr/lib/kernel/install.d/50-dracut.install
    rm -f /etc/dracut.conf.d/generic.conf
    # remove machine state files for one final time before we unmount
    # to tell systemd that in fact, this will be the first boot
    systemd-firstboot --reset
}

kernelinstall_prep() {
    mv /usr/lib/kernel/install.d/50-dracut.install /tmp/dracut.install
    echo 'hostonly="no"' > /etc/dracut.conf.d/generic.conf
    trap kernelinstall_cleanup EXIT
}

source /usr/src/ultramarine-bootc/base/common.sh
KERNEL_VERSION=$(get_kernel_version)
grub2-mkconfig -o /boot/grub2/grub.cfg
# hack: disable dracut for now; trap restores it on exit
kernelinstall_prep
kernel-install add -v $KERNEL_VERSION /lib/modules/$KERNEL_VERSION/vmlinuz

# Change `ro` to `rw` for first boot
# Fixes a weird issue where boot gets stuck on `ro` mode when there's no
# /etc/hostname and other machine state
# However we do want machine state to be wiped before first boot
# for obvious reasons
for file in /boot/loader/entries/*.conf; do
    # change `ro` to `rw` if it ends with newline
    sed -i "s|ro[[:space:]]*$|rw|" "$file"
done
