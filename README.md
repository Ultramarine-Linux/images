# Ultramarine Linux Image building scripts

This repository contains various scripts and configuration files for building an Ultramarine Linux image.

It mainly contains Kickstart scripts, scripts which are used by the Anaconda installer to automatically install the initial Ultramarine Linux image, which are then built into the final bootable image using weldr's [Lorax](https://github.com/weldr/lorax) tool.

## Ultramarine Linux Docker/OCI image

Ultramarine also offers a minimal base Docker image, in rare cases when you want to run Ultramarine as a container.

The image itself is similar to the vanilla Fedora image, but includes the Ultramarine Linux repositories and RPMFusion repositories. This may prove useful for some users who want a Fedora-like environment, but with some extra packages.

## Building locally

Ultramarine Linux provides a tool to help quickly building an image locally using a configuration file called [Onceler](https://github.com/Ultramarine-Linux/onceler). This tool is used to build a bootable image from a Kickstart file, and automatically deploy the image to your containers, or to a local directory.

To use Onceler to build an image, install Onceler and then run:

```
onceler <variant>
```

If you would like to build an image without using Onceler, we also included a Makefile in the repository. Install `lorax-lmc-novirt` and then run:

```
sudo make SPIN=<spin> image
```
