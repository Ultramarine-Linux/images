#!/bin/bash
sudo -s <<<"
echo Flattening Scripts...
ksflatten --config kickstarts/ultramarine-cyber.ks --output flattened.ks
echo ------------------------------------------------------- 
echo --------------------BUILDING ISO-----------------------
echo -------------------------------------------------------
rm -rf build/
livecd-creator flattened.ks -t tmp/ -f Ultramarine-Linux-Live
rm -rf tmp/
"
