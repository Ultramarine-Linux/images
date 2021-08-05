#!/bin/bash
sudo -s <<EOF
echo Flattening Scripts...
ksflatten --config kickstarts/ultramarine-cyber.ks --output flattened.ks
echo ------------------------------------------------------- 
echo --------------------BUILDING ISO-----------------------
echo -------------------------------------------------------
#livecd-creator --verbose --config flattened.ks --fslabel "Ultramarine-Linux" --cache tmp/cache/ | tee build.log
livemedia-creator\
 --make-iso\
 --ks flattened.ks\
 --nomacboot\
 --project "Ultramarine Linux"\
 --fs-label "Ultramarine-Linux-Live"\
 --location lorax/\
 --iso lorax/images/boot.iso\
 --no-virt
rm -rf tmp/
EOF