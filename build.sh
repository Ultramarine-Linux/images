#!/bin/bash
sudo -s <<EOF
echo ------------------------------------------------------- 
echo --------------------BUILDING ISO-----------------------
echo -------------------------------------------------------
livecd-creator --verbose --config flattened.ks --fslabel Ultramarine-Cyber --cache tmp/cache/
rm -rf tmp/
EOF