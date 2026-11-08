# Ultramarine Linux Image building scripts

This repository contains scripts and configuration files for building the Ultramarine Linux images.

## Dependencies

Install Katsu from [terra](https://github.com/terrapkg/packages)

```bash
dnf install katsu
```

## Building an ISO image

```bash
katsu -o iso katsu/modules/budgie/budgie-live.yaml
```

## Building a preinstalled image

```bash
katsu -o disk-image katsu/modules/flagship/flagship-live.yaml
```

## Ultramarine Linux Docker/OCI image

Ultramarine also offers minimal base [Docker images](https://github.com/orgs/Ultramarine-Linux/packages?repo_name=images), in rare cases when you want to run Ultramarine as a container.

The image itself is similar to the vanilla Fedora image, but includes the Ultramarine Linux, Terra, and RPMFusion repositories. This may prove useful for some users who want a Fedora-like environment, but with some extra packages.

## Folders guide

`katsu/modules/base` holds yamls and config scripts that many/all images need.

`katsu/modules/base/repodir` holds the package repositories included during build time.

`katsu/modules/flagship` flagship edition build scripts.

`katsu/modules/gnome` gnome edition build scripts.

`katsu/modules/plasma` plasma edition build scripts.

`katsu/modules/xfce` xfce edition build scripts.

`katsu/modules/server` server edition build scripts (preinstalled disk image and Anaconda installer ISO).

`katsu/modules/live` holds yamls and config scripts that live ISO images need.

`katsu/modules/ports/chromebook` scripts to build various types of chromebook images.

`katsu/modules/ports/surface` scripts to build surface images.

`katsu/modules/ports/wsl` scripts to build wsl builds.
