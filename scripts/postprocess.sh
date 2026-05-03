#!/bin/bash
# Postprocess mkosi disk image output
# We use this script here since mkosi's postoutput scripts
# are stuck in a sandbox, and we want privileged access outside it

set -euxo pipefail
. "$(dirname "${BASH_SOURCE[0]}")/mkosi.sh"


output="$(jq -r '.Output' "$MKOSI_CONFIG")"
format="$(jq -r '.OutputFormat' "$MKOSI_CONFIG" 2>/dev/null || true)"
architecture="$(jq -r '.Architecture' "$MKOSI_CONFIG")"

# crude example for a raw disk image:
img="mkosi.output/$output"

echo "disk image path: $img"

rootmnt="$(mktemp -d)"
xbootldrmnt="$rootmnt/boot"
efimnt="$xbootldrmnt/efi"
loop=""

cleanup() {
    set +e
    echo "cleaning up mountpoint: $rootmnt"
    umount -Rv "$rootmnt"
    echo "cleaning up loop device: $loop"
    [[ -n "$loop" ]] && losetup -d "$loop"
}
trap cleanup EXIT

test -n "$img" || exit 1

loop=$(losetup --find --show --partscan "$img")
echo "loop device: $loop"
udevadm settle || true

mount "${loop}p4" "$rootmnt"
mkdir -p "$xbootldrmnt"
mount "${loop}p3" "$xbootldrmnt"
mkdir -p "$efimnt"
mount "${loop}p2" "$efimnt"

mount -t devtmpfs devtmpfs "$rootmnt/dev"
mount -t devpts devpts "$rootmnt/dev/pts"
mount -t tmpfs tmpfs "$rootmnt/dev/shm"
mount -t proc proc "$rootmnt/proc"
mount -t sysfs sysfs "$rootmnt/sys"
mount -t tmpfs tmpfs "$rootmnt/tmp"
mount -t tmpfs tmpfs "$rootmnt/run"

chroot "$rootmnt" bash -s "$loop" "$architecture" <<'EOF'
set -euxo pipefail
loop="$1"
architecture="$2"
if [[ "$architecture" == "x86-64" ]]; then
    grub2-install --target=i386-pc "$loop"
fi
source /usr/src/ultramarine-bootc/base/common.sh
KERNEL_VERSION=$(get_kernel_version)
grub2-mkconfig -o /boot/grub2/grub.cfg
# hack: disable dracut for now
mv /usr/lib/kernel/install.d/50-dracut.install /tmp/dracut.install
echo 'hostonly="no"' > /etc/dracut.conf.d/generic.conf
kernel-install add -v $KERNEL_VERSION /lib/modules/$KERNEL_VERSION/vmlinuz
# then add it back
mv /tmp/dracut.install /usr/lib/kernel/install.d/50-dracut.install
rm /etc/dracut.conf.d/generic.conf

# Change `ro` to `rw` for first boot
# Fixes a weird issue where boot gets stuck on `ro` mode when there's no
# /etc/hostname and other machine state
# However we do want machine state to be wiped before first boot
# for obvious reasons
for file in /boot/loader/entries/*.conf; do
    # change `ro` to `rw` if it ends with newline
    sed -i "s|ro[[:space:]]*$|rw|" "$file"
done

EOF
