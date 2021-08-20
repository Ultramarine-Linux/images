repo --name="copr:copr.fedorainfracloud.org:stenstorp:budgie" --baseurl=https://download.copr.fedorainfracloud.org/results/stenstorp/budgie/fedora-$releasever-$basearch/

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

lightdm
slick-greeter

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
arc-theme
arc-theme-plank
gnome-disk-utility
gnome-packagekit
@ Games
gnome-packagekit*
-gdm

#install budgie
xorg-x11-server-Xorg
budgie-desktop
#funny theme


%end