#!/bin/bash
spin="${1?"Usage: $0 Spin"}"
version=${2}

if [ -z "$1" ]
  then
    version=$(rpm -E '%{fedora}')
fi


sudo -s <<<"
rm -f flattened.ks
rm -f -- ${spin}.iso
echo Flattening Scripts...
ksflatten --config kickstarts/ultramarine-${spin}.ks --output flattened.ks && sed -i 's/\r$//' flattened.ks
echo ------------------------------------------------------- 
echo --------------------BUILDING ISO-----------------------
echo -------------------------------------------------------
rm -rf build/
livecd-creator flattened.ks\
 -v\
 --compression-type zstd\
 -f Ultramarine\
 --title 'Ultramarine Linux'\
 --product 'Ultramarine Linux' --releasever=${version}
mv Ultramarine.iso ${spin}.iso
echo Cleaning up...
rm -rf -f /var/tmp/imgcreate* > /dev/null
rm -rf /tmp/lapis
"
