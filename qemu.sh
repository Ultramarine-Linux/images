#!/bin/bash

set -x

# This script is used to aid in testing Katsu builds. It will help you quickly set up a QEMU VM test environment so
# you can manually test builds. This script shouldn't be used in prod and is meant for development only.

# USAGE
# ./qemu.sh [qemu-disk|qemu-iso]
# If no argument is provided, qemu-disk is used by default


# Variables for test environment

# load .env if it exists
if [ -f .env ]; then
    source .env
fi

# default values for QEMU
: ${QEMU_MEM:="4G"}
: ${QEMU_CPU:="4"}
: ${QEMU_BOOT:="uefi"}

TEST_HOME=$(pwd)/.test
KATSU_WORK=$(pwd)/katsu-work

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


# Quickly get the absolute path of a file

function abs_path {
    echo $(realpath $1)
}

KATSU_IMG_PATH="$KATSU_WORK/image/katsu.img"


if [ "$SCRIPT_MODE" = "qemu-disk" ]; then
    QEMU_ARGS="-drive file="$KATSU_IMG_PATH",format=raw,if=virtio"
else
    QEMU_ARGS="-cdrom $(find_iso)"
fi

# if QEMU_BOOT = "uefi" then add UEFI firmware
if [ "$QEMU_BOOT" = "uefi" ]; then
    QEMU_ARGS+=" -bios /usr/share/OVMF/OVMF_CODE.fd"
fi


# Run QEMU


function setup_test_home {
    mkdir -p $TEST_HOME
    mkdir -p $KATSU_WORK
}

qemu-kvm \
    -machine type=q35,accel=kvm \
    -cpu host \
    -m $QEMU_MEM \
    -smp $QEMU_CPU \
    $QEMU_ARGS