#!/bin/sh -x

systemctl disable systemd-networkd-wait-online systemd-networkd systemd-networkd.socket

# Enable livesys services
systemctl enable livesys.service
systemctl enable livesys-late.service

# enable tmpfs for /tmp
systemctl enable tmp.mount

cat >> /etc/fstab << EOF
vartmp   /var/tmp    tmpfs   defaults   0  0
EOF

# work around for poor key import UI in PackageKit
# rm -f /var/lib/rpm/__db*
echo "Packages within this LiveCD"
rpm -qa --qf '%{size}\t%{name}-%{version}-%{release}.%{arch}\n' |sort -rn
# Note that running rpm recreates the rpm db files which aren't needed or wanted
# rm -f /var/lib/rpm/__db*


# go ahead and pre-make the man -k cache (#455968)
/usr/bin/mandb -c

# remove random seed, the newly installed instance should make it's own
rm -f /var/lib/systemd/random-seed

# convince readahead not to collect
# FIXME: for systemd

echo 'File created by kickstart. See systemd-update-done.service(8).' \
    | tee /etc/.updated >/var/.updated


# Disable network service here, as doing it in the services line
# fails due to RHBZ #1369794
systemctl disable network
systemctl disable systemd-networkd
systemctl disable systemd-networkd-wait-online
systemctl disable openvpn-client@\*.service
systemctl disable openvpn-server@\*.service


# Remove machine-id on pre generated images
rm -f /etc/machine-id
touch /etc/machine-id

# make sure there aren't core files lying around
rm -f /core*

systemctl set-default graphical.target


cat >> /var/lib/livesys/livesys-session-extra << EOF

# Install welcome screen autostart file
mkdir -p /home/liveuser/.config/autostart
cat > /home/liveuser/.config/autostart/ultramarine-welcome.desktop << EOA
[Desktop Entry]
Name=Welcome to Ultramarine
Comment=Welcome to Ultramarine
Exec=/usr/share/anaconda/gnome/fedora-welcome
Terminal=false
Type=Application
EOA


EOF