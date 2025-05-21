#!/bin/bash

# https://superuser.com/a/1294893
UUID="7E5D-2CF4"
printf "\x${UUID:7:2}\x${UUID:5:2}\x${UUID:2:2}\x${UUID:0:2}" \
| dd bs=1 seek=67 count=4 conv=notrunc of=/dev/loop0s1

sed -e 's/UUID=.*\/boot\/efi/UUID=$UUID \/boot\/efi/' /etc/fstab | sudo tee /etc/fstab
sudo systemctl daemon-reload
