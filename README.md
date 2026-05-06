# Ultramarine Disk images

This repository contains mkosi configs and scripts to build a Ultramarine Linux image for 44 and later

## how this works

This exploits the new Ultramarine 44 feature: Dual-format bootc images, which allows you to use the same OCI image for booting through bootc to install a traditional, stateful Ultramarine installation.

Most of the filesystem is provisioned through mkosi itself, with one `postprocess.sh` script working outside due to sandboxing limitations with `mkosi.postoutput` scripts. For some reason you cannot call postoutput scripts in a privileged context, possibly due to some sandboxing assumption, we work around this by simply going outside the container itself and doing it manually

## Building

Run the Just recipe:

```bash
just full-build
```

This will automatically pull OCI images from the bootc tree, and 

you now have yourself a bootable, stateful artifact from an Ultramarine bootc image