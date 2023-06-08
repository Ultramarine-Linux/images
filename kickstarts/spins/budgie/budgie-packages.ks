%packages
@core
@standard
@base-x
@input-methods
@dial-up
@multimedia
@fonts
@budgie-desktop
@^flagship-product-environment
policycoreutils
coreutils
gnome-software
-setroubleshoot

lightdm
lightdm-gtk
lightdm-gtk-greeter-settings

gnome-terminal
gnome-terminal-nautilus
gnome-system-monitor
-totem
clapper
-gedit
gnome-text-editor
file-roller
evince
seahorse
gnome-sound-recorder
gnome-disk-utility
eog
gnome-screenshot
abrt
gnome-weather
gnome-clocks
xdg-user-dirs-gtk
-gnome-control-center
-gdm
xdg-desktop-portal-gtk
python3-psutil

fluent-theme
fluent-icon-theme

ultramarine-release-flagship
ultramarine-backgrounds-gnome
ultramarine-backgrounds-basic
ultramarine-flagship-filesystem

#install budgie
xorg-x11-server-Xorg
budgie-desktop
budgie-extras
budgie-extras-daemon
budgie-desktop-view
gnome-backgrounds
# Don't pull in Fedora's defaults
-budgie-desktop-defaults


%end
