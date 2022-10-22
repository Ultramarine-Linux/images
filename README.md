# Ultramarine Linux Image building scripts

This repository contains various scripts and configuration files for building an Ultramarine Linux image.

It mainly contains Kickstart scripts, scripts which are used by the Anaconda installer to automatically install the initial Ultramarine Linux image, which are then built into the final bootable image using weldr's [Lorax](https://github.com/weldr/lorax) tool.

## Ultramarine Linux Docker/OCI image

Ultramarine also offers a minimal base Docker image, in rare cases when you want to run Ultramarine as a container.

The image itself is similar to the vanilla Fedora image, but includes the Ultramarine Linux repositories and RPMFusion repositories. This may prove useful for some users who want a Fedora-like environment, but with some extra packages.

## Building locally

To build the image locally, you need to have the following installed:
- Lorax
- Anaconda
- pykickstart

You can then run the following command to build the image:
```
./build.sh <VARIANT>
```