#!/bin/sh

# the preinstalled image built by katsu
built_image=$1

# the zip file with each parition as a seperate image, as expected by the Asahi Linux installer
output_zip=$2

# attach image to loop device to copy out partitions
loop_device=$(sudo losetup --partscan --show -f $built_image)

# get root/boot UUIDs
boot_uuid=$(sudo blkid -o value -s UUID -p ${loop_device}p2)
root_uuid=$(sudo blkid -o value -s UUID -p ${loop_device}p3)

# mount efi and extract it
mkdir efi
mkdir esp
sudo mount ${loop_device}p1 efi
cp -r efi/* esp/
sudo umount efi
rmdir efi

# create boot image
fallocate -l 1GiB boot.img
boot_loop=$(sudo losetup --partscan --show -f boot.img)
sudo mkfs.ext4 $boot_loop
mkdir umboot
sudo mount ${loop_device}p2 umboot
mkdir boot
sudo mount ${boot_loop} boot
sudo cp -a umboot/* boot/
sudo rm -rf boot/efi
sudo umount umboot/ boot/
rmdir umboot/ boot/

# create root image
fallocate -l 16GiB root.img
root_loop=$(sudo losetup --partscan --show -f root.img)
sudo mkfs.btrfs $root_loop
mkdir umroot
sudo mount ${loop_device}p3 umroot
mkdir root
sudo mount ${root_loop} root
## TODO: make base image be btrfs so btrfs works
# sudo btrfs send umroot/ | sudo btrfs receive root/
# sudo btrfs send umroot/home | sudo btrfs receive root/home
sudo cp -a umroot/* root/
sudo rm -rf root/boot
sudo umount umroot/ root/
rmdir umroot/ root/

# copy icon
cp $(dirname "$0")/Ultramarine.icns ultramarine.icns

# clean up um loop
sudo losetup -d $loop_device

# set UUIDs for new images
sudo tune2fs -U $boot_uuid $boot_loop
sudo losetup -d $boot_loop

sudo btrfstune -f -U $root_uuid $root_loop
sudo losetup -d $root_loop

# create zip
if [[ $output_zip == "" ]]; then
  output_zip=${built_image::-4}.zip
fi

zip -r $output_zip boot.img root.img esp ultramarine.icns

# cleanup
rm -rf esp boot.img root.img ultramarine.icns
