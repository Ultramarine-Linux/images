sed -e 's/UUID=.*\/boot\/efi/UUID=7E5D-2CF4 \/boot\/efi/' /etc/fstab | sudo tee /etc/fstab
sudo systemctl reload-daemon
