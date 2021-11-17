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
lightdm-gtk-greeter-settings

gnome-terminal
gnome-terminal-nautilus
gnome-system-monitor
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
gnome-weather
gnome-clocks
@ Games
yumex-dnf
xdg-user-dirs-gtk
-gdm

fluent-theme
fluent-icon-theme

ultramarine-release-identity-flagship
ultramarine-release-flagship
ultramarine-backgrounds-gnome
ultramarine-backgrounds-basic

#install budgie
xorg-x11-server-Xorg
budgie-desktop
budgie-extras
budgie-extras-daemon
budgie-desktop-view
#funny theme


%end