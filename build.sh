#!/bin/bash
spin="${1}"
sudo -s <<<"
echo Flattening Scripts...
ksflatten --config kickstarts/ultramarine-${spin}.ks --output flattened.ks
echo ------------------------------------------------------- 
echo --------------------BUILDING ISO-----------------------
echo -------------------------------------------------------
rm -rf build/
livecd-creator flattened.ks -t tmp/ --compression-type zstd -f Ultramarine-Linux-Live
rm -rf tmp/
"
