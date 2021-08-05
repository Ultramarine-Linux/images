#!/bin/bash
sudo -s <<EOF
echo Flattening Scripts...
ksflatten --config kickstarts/ultramarine-cyber.ks --output flattened.ks
echo ------------------------------------------------------- 
echo --------------------BUILDING ISO-----------------------
echo -------------------------------------------------------
livecd-creator --verbose --config flattened.ks --fslabel "Ultramarine-Linux" --cache tmp/cache/ | tee build.log
rm -rf tmp/
EOF