#!/bin/bash
kickstartFile="${1}"
project="${2}"
livemediaFsLabel="${3}"

sudo -s <<<"
echo Flattening Scripts...
ksflatten --config ${kickstartFile} --output flattened.ks
echo ------------------------------------------------------- 
echo --------------------BUILDING ISO-----------------------
echo -------------------------------------------------------
livemedia-creator\
 --make-iso\
 --ks flattened.ks\
 --nomacboot\
 --project ${project}\
 --fs-label ${livemediaFsLabel}\
 --location lorax/\
 --iso lorax/images/boot.iso\
 --no-virt\
 --iso-only\
 --resultdir build/
rm -rf tmp/
"
