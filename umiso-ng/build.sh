#!/bin/bash -x
RELEASEVER=38
# Test rootfs build


# Build an instroot from host using DNF5
sudo dnf5 install dnf5 @core kernel-core kernel kernel-modules kernel-modules-extra dracut-live grub2-efi-ia32-cdboot grub2-pc-modules grub2-pc grub2-efi-cdboot shim --releasever=${RELEASEVER} --installroot=$PWD/root/ --use-host-config


sudo cp root/boot/initramfs-6.3.12-202.fsync.fc38.x86_64.img iso/initramfs.img

# follow instructions on limine for setting up limine folders

# turn instroot into squashfile

sudo mksquashfs root/ iso/LiveOS/squashfs.img

# now make a funny bootloader image with GRUB or install limine

# then use `dracut` to create a initramfs and vmlinuz or something

# then use xorriso to make an iso like this:

xorriso -as mkisofs -b boot/limine/limine-bios-cd.bin \
        -no-emul-boot -boot-load-size 4 -boot-info-table \
        --efi-boot boot/limine/limine-uefi-cd.bin \
        -efi-boot-part --efi-boot-image --protective-msdos-label \
        iso -volid ISO -o image.iso


# arbitary path, but this is where I have limine installed
/home/cappy/Downloads/limine-5.20230709.0-binary/limine bios-install image.iso
