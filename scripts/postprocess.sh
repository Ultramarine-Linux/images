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

# Copy the chroot script into the image's /tmp (a tmpfs) so it's cleaned up
# automatically when cleanup() unmounts the filesystems.
export LOOP="$loop"
export ARCHITECTURE="$architecture"
cp "$(dirname "${BASH_SOURCE[0]}")/chroot-setup.sh" "$rootmnt/tmp/chroot-setup.sh"
chroot "$rootmnt" bash /tmp/chroot-setup.sh
