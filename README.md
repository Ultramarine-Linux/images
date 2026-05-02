# mkosi scratchpad

this repository contains an attempt to create mutable, stateful disk images from a bootc tree

don't expect this to boot, it might boot

## how this works

This exploits the new Ultramarine 44 feature: Dual-format bootc images, which allows you to use the same OCI image for booting through bootc to install a traditional, stateful Ultramarine installation.

Most of the filesystem is provisioned through mkosi itself, with one `postprocess.sh` script working outside due to sandboxing limitations with `mkosi.postoutput` scripts. For some reason you cannot call postoutput scripts in a privileged context, possibly due to some sandboxing assumption, we work around this by simply going outside the container itself and doing it manually

## building

1. mount the base container
   ```bash
   sudo podman pull ghcr.io/ultramarine-linux/base-bootc:44
   sudo podman create --name um44 ghcr.io/ultramarine-linux/base-bootc:44
   sudo podman mount um44
   ```

   then edit `mkosi.conf` `BaseTrees=` option to the outputted mountpoint (todo: a `mkosi.sync/configure` script to ease this pain)
   
2. build the image
   ```
   just build
   ```

3. profit?

you now have yourself a bootable, stateful artifact from an Ultramarine bootc image