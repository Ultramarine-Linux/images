#!/bin/bash
sudo -s <<EOF
rm -rf lorax/
lorax -p Fedora -v 34 -r 34 \
-s http://dl.fedoraproject.org/pub/fedora/linux/releases/34/Everything/x86_64/os/ \
-s http://dl.fedoraproject.org/pub/fedora/linux/updates/34/Everything/x86_64/ \
./lorax/ \
--force \
--nomacboot
EOF