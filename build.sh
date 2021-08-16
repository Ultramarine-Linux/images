#!/bin/bash
spin="${1?"Usage: $0 Spin"}"


rm -f flattened.ks
rm -f -- *.iso
sudo -s <<<"
echo Flattening Scripts...
ksflatten --config kickstarts/ultramarine-${spin}.ks --output flattened.ks && sed -i 's/\r$//' flattened.ks
echo ------------------------------------------------------- 
echo --------------------BUILDING ISO-----------------------
echo -------------------------------------------------------
rm -rf build/
livecd-creator flattened.ks\
 -v\
 -d\
 --compression-type zstd\
 -f Ultramarine-Linux-Live\
 --title 'Ultramarine Linux 34'\
 --product 'Ultramarine Linux'
rm -rf tmp/
"
