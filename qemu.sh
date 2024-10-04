#!/bin/bash

set -x

# This script is used to aid in testing Katsu builds. It will help you quickly set up a QEMU VM test environment so
# you can manually test builds. This script shouldn't be used in prod and is meant for development only.

# USAGE
# ./qemu.sh [qemu-disk|qemu-iso]
# If no argument is provided, qemu-disk is used by default

# Variables for test environment
# You can save these in a .env file in the same directory as this script


# load .env if it exists
if [ -f .env ]; then
    . .env
fi

# default values for QEMU
: ${QEMU_MEM:="4G"}
: ${QEMU_CPU:="4"}
: ${QEMU_BOOT:="uefi"}
: ${QEMU_DISK_SIZE:="20G"}
: ${QEMU_ARGS:=""}
TEST_HOME=$(pwd)/.test
KATSU_WORK=$(pwd)/katsu-work

TEST_DISK="$TEST_HOME/disk.img"

# Get testing mode from second argument

if [ -z "$1" ]; then
    SCRIPT_MODE="qemu-disk"
else
    SCRIPT_MODE=$1
fi

function find_iso {
    iso_path=$(find $KATSU_WORK -name "*.iso" | head -n 1)
    if [ -z "$iso_path" ]; then
        echo "No ISO found in $KATSU_WORK"
        exit 1
    fi
    echo $iso_path
}

function create_disk {
    qemu-img create -f raw "$TEST_DISK" "$QEMU_DISK_SIZE"
}

# Quickly get the absolute path of a file

function abs_path {
    echo $(realpath $1)
}

KATSU_IMG_PATH="$KATSU_WORK/image/katsu.img"

# Mode-specific setup
case "$SCRIPT_MODE" in
qemu-disk)
    QEMU_ARGS+=" -drive file="$KATSU_IMG_PATH",format=raw,if=virtio "
    ;;
qemu-iso)
    QEMU_ARGS+=" -cdrom $(find_iso) "
    ;;
none)
    # Boot without any extra disks attached
    echo "Booting without any extra disks attached"
    ;;
cleanup)
    # Clean up test environment
    sudo umount $KATSU_WORK/chroot --recursive -v
    sudo losetup -d $(losetup -j $KATSU_IMG_PATH | cut -d: -f1)
    exit 0
    ;;

wipe)
    rm -rf $KATSU_WORK
    rm -rf $TEST_HOME
    exit 0
    ;;
*)
    echo "Invalid mode: $SCRIPT_MODE"
    exit 1
    ;;
esac

# Setup test environment

function setup_test_home {
    mkdir -p $TEST_HOME
    mkdir -p $KATSU_WORK
}

setup_test_home

# create disk if not exist
if [ ! -f "$TEST_DISK" ]; then
    create_disk
fi

QEMU_ARGS=" -drive file="$TEST_DISK",format=raw,if=virtio $QEMU_ARGS"

# if QEMU_BOOT = "uefi" then add UEFI firmware
if [ "$QEMU_BOOT" = "uefi" ]; then
    QEMU_ARGS+=" -bios /usr/share/OVMF/OVMF_CODE.fd "
fi

# end of mode-specific setup

# Finally, run QEMU

qemu-kvm \
    -vga qxl \
    -machine type=q35,accel=kvm \
    -cpu host \
    -m $QEMU_MEM \
    -smp $QEMU_CPU \
    $QEMU_ARGS
