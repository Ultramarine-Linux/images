# PLEASE READ ME IF YOU WANT TO FLASH THE DISK IMAGES ON YOUR DRIVE!!!!

The images are UEFI-only. You cannot use this image on a legacy BIOS system.

If you're flashing this and are unable to boot, please check the following:

1. Make sure your system supports UEFI booting.
2. Make sure your system is **not** set to legacy (MBR) booting.
3. Make sure your system is set to boot from the correct drive.

If you're still having issues, you then can post an issue.

## ARM Devices

This image should support most ARM devices, but the bootloader included on here is for the Raspberry Pi 4. If you're using a different device, you may need to
slightly alter the image (and add your own devicetrees) to get your system to load U-Boot and boot properly.
