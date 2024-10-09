# Microsoft Surfaces

These are not a new edition, they are simply Ultramarine with the Surface kernel preinstalled.

Special thanks to the Linux Surface team.

## Known Issues

These are issues that the community has experienced personally in Ultramarine, there may be more issues covered in the [Linux Surface Wiki](https://github.com/linux-surface/linux-surface/wiki)

### Surface Laptop Go

- Intel Panel Self Refresh PSR causes screen tearing on Surface Laptop Go
  To solve this, simply add `i915.enable_psr=0` to your kernel commandline.
- Touchpad may stop responding after resuming from suspend
  You will have to reload the touchpad driver, see instructions on doing this after resume [here](https://github.com/linux-surface/linux-surface/wiki/Surface-Laptop-Go).

### Surface Pro 3

- Type cover causes the system to randomly suspend in GNOME Edition
- Thermal management is less effective under Linux
