#!/bin/bash
# Postprocess mkosi disk image output
# We use this script here since mkosi's postoutput scripts
# are stuck in a sandbox, and we want privileged access outside it

set -euxo pipefail

MKOSI_CONFIG="$(realpath mkosi.output/manifest.json)"

if ! [[ -f "$MKOSI_CONFIG" ]]; then
    echo "mkosi output manifest not found: $MKOSI_CONFIG"
    exit 1
fi

output="$(jq -r '.Output' "$MKOSI_CONFIG")"
format="$(jq -r '.OutputFormat' "$MKOSI_CONFIG" 2>/dev/null || true)"


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

chroot "$rootmnt" bash -s "$loop" <<'EOF'
set -euxo pipefail
loop="$1"
grub2-install --target=i386-pc "$loop"
source /usr/src/ultramarine-bootc/base/common.sh
KERNEL_VERSION=$(get_kernel_version)
# Ensure hostname exists and is not empty for dracut
ls -la /etc/hostname || echo "hostname file does not exist"
file /etc/hostname || true
test -s /etc/hostname || echo "localhost" > /etc/hostname
grub2-mkconfig -o /boot/grub2/grub.cfg

kernel-install add -v $KERNEL_VERSION /lib/modules/$KERNEL_VERSION/vmlinuz
EOF
