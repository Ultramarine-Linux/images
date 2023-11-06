#!/bin/sh -x

systemctl disable systemd-networkd-wait-online systemd-networkd systemd-networkd.socket || true

# Enable livesys services
systemctl enable livesys.service
systemctl enable livesys-late.service

# enable tmpfs for /tmp
systemctl enable tmp.mount

cat >>/etc/fstab <<EOF
vartmp   /var/tmp    tmpfs   defaults   0  0
EOF

# work around for poor key import UI in PackageKit
# rm -f /var/lib/rpm/__db*
echo "Packages within this LiveCD"
rpm -qa --qf '%{size}\t%{name}-%{version}-%{release}.%{arch}\n' | sort -rn
# Note that running rpm recreates the rpm db files which aren't needed or wanted
# rm -f /var/lib/rpm/__db*

# go ahead and pre-make the man -k cache (#455968)
/usr/bin/mandb -c

# remove random seed, the newly installed instance should make it's own
rm -f /var/lib/systemd/random-seed

# convince readahead not to collect
# FIXME: for systemd

echo 'File created by katsu. See systemd-update-done.service(8).' |
    tee /etc/.updated >/var/.updated

# Set locales in chroot
cat >/etc/locale.conf <<EOF
LANG=en_US.UTF-8
LANGUAGE=en_US.UTF-8
LC_ALL=en_US.UTF-8
EOF

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

# attempt to reinstall anaconda-core to fix localization issues
# it actually cannot reinstall it, but this somehow fixes the issue
# I assume scuffed rpm db or something
# If anyone manages to figure out why this works, please let me know - @korewachino
dnf reinstall -y anaconda-core || true && dnf clean all

cat >>/var/lib/livesys/livesys-session-extra <<EOF

# Install welcome screen autostart file
mkdir -p /home/liveuser/.config/autostart
cat > /home/liveuser/.config/autostart/ultramarine-welcome.desktop << EOA
[Desktop Entry]
Name=Welcome to Ultramarine
Comment=Welcome to Ultramarine
Exec=bash -c "pkexec glib-compile-schemas /usr/share/glib-2.0/schemas || : && /usr/share/anaconda/gnome/fedora-welcome"
Terminal=false
Type=Application
EOA

EOF

echo "Setting up NVIDIA driver install script"

anaconda_dir=/usr/share/anaconda/post-scripts

mkdir -p "$anaconda_dir"

cat >$anaconda_dir/nvidia.ks <<EOF
# Detect NVIDIA GPU and install drivers

%post --nochroot

# copy /etc/resolv.conf to chroot
cp /etc/resolv.conf /mnt/sysimage/etc/resolv.conf

%end

%post

detect_nvidia() {
    # return 0 if nvidia is found
    lspci | grep -q -i NVIDIA
}


get_nvidia_driver_version() {
    nvidia_model=$(lspci | grep -i NVIDIA | head -n 1 | cut -d ':' -f 3 | cut -d '[' -f 1 | sed -e 's/^[[:space:]]*//')
    # split by space and get the last element

    try_nvidia_version=$(echo "$nvidia_model" | awk '{print $NF}')

    # if it is GF***, then it is old, so we need to use 340xx
    # if it's a GK***, model, Kepler, we need to use 470xx drivers

    if [[ "$try_nvidia_version" == "GK"* ]]; then
        echo "akmod-nvidia-470xx xorg-x11-drv-nvidia-cuda-470xx xorg-x11-drv-nvidia-470xx" 
    else
        echo "akmod-nvidia xorg-x11-drv-nvidia-cuda xorg-x11-drv-nvidia"
    fi
}

install_nvidia() {
    # install nvidia drivers
    # check if we even have internet
    if ! ping -c 1 ultramarine-linux.org
    then
        echo "No internet connection, skipping"
        return 1
    fi
    dnf install -y $(get_nvidia_driver_version)
    dnf install -y libva-nvidia-driver --allowerasing
}


if detect_nvidia; then
    echo "NVIDIA GPU detected, installing drivers"
    install_nvidia
else
    echo "No NVIDIA GPU detected, skipping"
fi
%end
EOF
