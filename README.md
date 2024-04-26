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

## Status of Images (UM40)

### Flagship

- ✓ x86 Live
- ☓ ARM Live
- ✓ x86 Preinstalled
- ☓ ARM Preinstalled
- ☓ x86 Chromebook
- ☓ Chromebook mt8183
- ☓ Chromebook mt8192
- ☓ Chromebook SC-7C
- ☓ Chromebook Stoney Ridge

### GNOME

- ✓ x86 Live
- ☓ ARM Live
- ✓ x86 Preinstalled
- ☓ ARM Preinstalled
- ☓ x86 Chromebook
- ☓ Chromebook mt8183
- ☓ Chromebook mt8192
- ☓ Chromebook SC-7C
- ☓ Chromebook Stoney Ridge

### KDE

- ☓ x86 Live
- ☓ ARM Live
- ☓ x86 Preinstalled
- ☓ ARM Preinstalled
- ☓ x86 Chromebook
- ☓ Chromebook mt8183
- ☓ Chromebook mt8192
- ☓ Chromebook SC-7C
- ☓ Chromebook Stoney Ridge

### Pantheon

_Note: Pantheon Edition builds are failing due to an upstream issue with Mutter_

- ☓ x86 Live
- ☓ ARM Live
- ☓ x86 Preinstalled
- ☓ ARM Preinstalled
- ☓ x86 Chromebook
- ☓ Chromebook mt8183
- ☓ Chromebook mt8192
- ☓ Chromebook SC-7C
- ☓ Chromebook Stoney Ridge

### Xfce

- ☓ x86 Live
- ☓ ARM Live
- ☓ x86 Preinstalled
- ☓ ARM Preinstalled
- ☓ x86 Chromebook
- ☓ Chromebook mt8183
- ☓ Chromebook mt8192
- ☓ Chromebook SC-7C
- ☓ Chromebook Stoney Ridge
