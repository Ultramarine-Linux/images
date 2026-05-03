# Chromebook

## Building images

The happy path for building ready-to-install Ultramarine for Chromebook images is to generate an ISO image with the Chromebook specific packages included, then impregnate it with a Submarine partition. This essentially creates a bootable GPT disk which has two partitions: one for the Submarine bootloader and one for the Ultramarine ISO.

This has the benefit of being able to treat the image as just a special "ISO", and reusing our existing pipeline to build the ISO image.
