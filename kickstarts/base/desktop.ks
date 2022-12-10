# base-desktop.ks
#
# Defines the basics for a basic desktop environment.

%packages

# Common modules (see fedora-workstation-common.ks)
@base-x
@core
@hardware-support
bash-completion
bind-utils
btrfs-progs
microcode_ctl
psmisc
# Multimedia
@multimedia
libva-vdpau-driver
libvdpau-va-gl
mesa-*-drivers
-mesa-full*
xorg-x11-drivers
#akmod-nvidia # NVIDIA drivers because nouveau isnt loading for some reason

xorg-x11-drv-nouveau
procps-ng

# Fonts
google-noto-sans-fonts
google-noto-sans-mono-fonts
google-noto-serif-fonts
@fonts
-google-noto-emoji-color-fonts
# We like Twemoji
twitter-twemoji-fonts
liberation-mono-fonts
liberation-s*-fonts
cascadia-*-*-fonts

# Networking
@networkmanager-submodules
firewalld
firewall-config

# Internet
firefox
-fedora-bookmarks
#mozilla-openh264
# Software
PackageKit
PackageKit-gstreamer-plugin
PackageKit-command-not-found
xdg-desktop-portal
# deltarpm
dnf-plugins-core
# drpm
flatpak
flatpak-selinux-fix

# System
rpm-plugin-systemd-inhibit

# Tools
blivet-gui			# Storage management
exfatprogs
htop
rsync
unar
git

# The rice
ultramarine-shell-config

%end


%post

# Disable weak dependencies to avoid unwanted stuff
echo "install_weak_deps=False" >> /etc/dnf/dnf.conf
cat >> /etc/dnf/dnf.conf << EOF
defaultyes=True
max_parallel_downloads=20

EOF

%end
