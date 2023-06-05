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
psmisc

# Multimedia
@multimedia
@sound-and-video

libva-vdpau-driver
libvdpau-va-gl

mesa-*-drivers
-mesa-va-drivers
mesa-va-drivers-freeworld
-mesa-vdpau-drivers
mesa-vdpau-drivers-freeworld

xorg-x11-drivers
xorg-x11-drv-nouveau

nvidia-vaapi-driver
#akmod-nvidia # NVIDIA drivers because nouveau isnt loading for some reason

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
mozilla-openh264

# Software
PackageKit
PackageKit-gstreamer-plugin
PackageKit-command-not-found
xdg-desktop-portal
deltarpm
dnf-plugins-core
drpm
flatpak
flatpak-selinux-fix

# System
rpm-plugin-systemd-inhibit

# Tools
exfatprogs
htop
rsync
unar
git

# The rice
ultramarine-shell-config

%end


%post
# Delete the firefox redhat configs, debranding
rm -rf /usr/lib64/firefox/browser/defaults/preferences/firefox-redhat-default-prefs.js
%end
