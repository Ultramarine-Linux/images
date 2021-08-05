#!/bin/bash
sudo -s <<EOF
echo Flattening Scripts...
ksflatten --config kickstarts/ultramarine-cyber.ks --output flattened.ks
echo ------------------------------------------------------- 
echo --------------------BUILDING ISO-----------------------
echo -------------------------------------------------------
livecd-creator --verbose --config flattened.ks --fslabel Ultramarine-Cyber --cache tmp/cache/
rm -rf tmp/
EOF