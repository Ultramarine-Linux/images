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

### Notes

- Pantheon is not currently being built
- Chromebook images are shown as failing due to me not setting them up to build yet

### Flagship

- ☓ x86 Live
- ✓ ARM Live
- ✓ x86 Preinstalled
- ✓ ARM Preinstalled
- ☓ x86 Chromebook
- ☓ Chromebook mt8183
- ☓ Chromebook mt8192
- ☓ Chromebook SC-7C
- ☓ Chromebook Stoney Ridge

### GNOME

- ☓ x86 Live
- ✓ ARM Live
- ✓ x86 Preinstalled
- ✓ ARM Preinstalled
- ☓ x86 Chromebook
- ☓ Chromebook mt8183
- ☓ Chromebook mt8192
- ☓ Chromebook SC-7C
- ☓ Chromebook Stoney Ridge

### KDE

- ☓ x86 Live
- ✓ ARM Live
- ✓ x86 Preinstalled
- ✓ ARM Preinstalled
- ☓ x86 Chromebook
- ☓ Chromebook mt8183
- ☓ Chromebook mt8192
- ☓ Chromebook SC-7C
- ☓ Chromebook Stoney Ridge

### Pantheon

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
- ✓ ARM Live
- ✓ x86 Preinstalled
- ✓ ARM Preinstalled
- ☓ x86 Chromebook
- ☓ Chromebook mt8183
- ☓ Chromebook mt8192
- ☓ Chromebook SC-7C
- ☓ Chromebook Stoney Ridge

### Base/Preinstalled

- ✓ x86
- ✓ ARM

### Docker

- ✓ x86
- ☓ ARM
- ✓ x86 Devtools
- ☓ ARM Devtools
