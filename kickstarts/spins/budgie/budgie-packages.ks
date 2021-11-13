#repo --name="copr:copr.fedorainfracloud.org:cappyishihara:budgie-desktop" --baseurl=https://download.copr.fedorainfracloud.org/results/cappyishihara/budgie-desktop/fedora-$releasever-$basearch/
# Now included in Ultramarine Repos
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
PackageKit-command-not-found

lightdm
lightdm-gtk

gnome-terminal
gnome-terminal-nautilus
gnome-system-monitor
flat-remix-theme
totem
gedit
gedit-color-schemes
file-roller
evince
evince-nautilus
seahorse
gnome-sound-recorder
gnome-disk-utility
eog
gnome-screenshot
abrt
gnome-tweaks
gnome-weather
gnome-clocks
@ Games
gnome-packagekit*
-gdm

#ultramarine-repos-budgie
ultramarine-release-identity-budgie
ultramarine-release-budgie
ultramarine-backgrounds-gnome

#install budgie
xorg-x11-server-Xorg
budgie-desktop
budgie-extras
budgie-extras-daemon
budgie-desktop-view
#funny theme


%end