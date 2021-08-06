#!/bin/bash
fedoraReleaseVer=${1}
buildArch=${2}
sudo -s <<<"
rm -rf lorax/
lorax -p Fedora -v ${fedoraReleaseVer} -r ${fedoraReleaseVer} \
-s http://dl.fedoraproject.org/pub/fedora/linux/releases/${fedoraReleaseVer}/Everything/${buildArch}/os/ \
-s http://dl.fedoraproject.org/pub/fedora/linux/updates/${fedoraReleaseVer}/Everything/${buildArch}/ \
./lorax/ \
--force \
--nomacboot
"
