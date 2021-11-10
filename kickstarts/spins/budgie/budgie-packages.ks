repo --name="copr:copr.fedorainfracloud.org:cappyishihara:budgie-desktop" --baseurl=https://download.copr.fedorainfracloud.org/results/cappyishihara/budgie-desktop/fedora-$releasever-$basearch/

%packages
@core
@standard
@base-x
@input-methods
@dial-up
@multimedia
@fonts
policycoreutils
coreutils
gnome-software
-setroubleshoot

lightdm
lightdm-gtk

tilix
gnome-system-monitor
flat-remix-theme
gedit
nautilus
tilix-nautilus
file-roller
evince
evince-nautilus
seahorse
gnome-sound-recorder
gnome-disk-utility
@ Games
gnome-packagekit*
-gdm

ultramarine-repos-budgie
ultramarine-release-identity-budgie
ultramarine-backgrounds-gnome

#install budgie
xorg-x11-server-Xorg
budgie-desktop
budgie-extras
budgie-extras-daemon
budgie-desktop-view
#funny theme


%end