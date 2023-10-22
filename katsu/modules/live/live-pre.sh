#!/bin/bash -x

mkdir -p $CHROOT/etc/rpm/macros.d/

echo "%_install_langs all" > $CHROOT/etc/rpm/macros.d/macros.lang