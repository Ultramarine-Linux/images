#!/usr/bin/env fish

set fish_trace 1

# This script is used to aid in testing Katsu builds. It will help you quickly set up a VM test environment so
# you can manually test builds. This script shouldn't be used in prod and is meant
# for development only.


# Variables for test environment
set KATSU_BIN "katsu"

# Directory for test data
set TEST_HOME (pwd)/.test

# katsu-work
set KATSU_WORK (pwd)/katsu-work

# Get testing mode from second argument
# Can be `qemu` or `wipe`
function get_mode
    if test (count $argv) -eq 0
        echo "qemu-disk"
    else
        echo $argv[1]
    end
end

set -x SCRIPT_MODE (get_mode $argv)

function find_iso
    set iso_path (find $KATSU_WORK -name "*.iso" | head -n 1)
    if test -z $iso_path
        echo "No ISO found in $KATSU_WORK"
        exit 1
    end
    echo $iso_path
end

function _qemu_arg_1
    if test $SCRIPT_MODE = "qemu-disk"
        echo "-drive"
    else
        echo "-cdrom"
    end
end
set KATSU_IMG_PATH "$KATSU_WORK/image/katsu.img"
function _qemu_arg_2
    if test $SCRIPT_MODE = "qemu-disk"
        echo "file=$KATSU_IMG_PATH,format=raw,if=virtio"
    else
        echo (find_iso)
    end
end

# Quickly get the absolute path of a file
function abs_path
    echo (realpath $argv)
end


# Create a test directory
mkdir -p $TEST_HOME



sudo chown $USER $KATSU_IMG_PATH

qemu-kvm -display gtk \
    -machine type=q35,accel=kvm \
    -cpu host \
    -smp 4 \
    -m 4G \
    -enable-kvm \
    -device virtio-net,netdev=vmnic -netdev user,id=vmnic \
    -bios /usr/share/OVMF/OVMF_CODE.fd \
    (_qemu_arg_1) (_qemu_arg_2)
    
    
    
    
