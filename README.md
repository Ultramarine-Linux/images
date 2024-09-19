# Ultramarine Linux Image building scripts

This repository contains various scripts and configuration files for building an Ultramarine Linux image.

## Building an image

Install Katsu

```bash
dnf install katsu
```

Run Katsu on manifest

```bash
katsu -o iso katsu/modules/flagship/flagship-live.yaml
```

## Ultramarine Linux Docker/OCI image

Ultramarine also offers a minimal base Docker image, in rare cases when you want to run Ultramarine as a container.

The image itself is similar to the vanilla Fedora image, but includes the Ultramarine Linux repositories and RPMFusion repositories. This may prove useful for some users who want a Fedora-like environment, but with some extra packages.

## Status of Images (UM41)

### Notes

- Chromebook images are shown as failing due to me not setting them up to build yet
-
