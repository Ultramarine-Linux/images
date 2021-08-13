#base fedora stuff

%include cyber-base.ks
%include desktop.ks

#cyber-desktop repo
repo --name "copr:copr.fedorainfracloud.org:cappyishihara:cyber-desktop" --baseurl https://download.copr.fedorainfracloud.org/results/cappyishihara/cyber-desktop/fedora-$releasever-$basearch/
repo --name "copr:copr.fedorainfracloud.org:cappyishihara:cyber-desktop-testing" --baseurl https://download.copr.fedorainfracloud.org/results/cappyishihara/cyber-desktop-testing/fedora-$releasever-$basearch/


%packages 
#x server
@base-x



#app groups because currently shit is empty
@firefox
@libreoffice
@admin-tools
@base-x
@core
@hardware-support
bash-completion
bind-utils
btrfs-progs
microcode_ctl
psmisc

fuse

# Office
libreoffice-kf5

-gnome-session
-@ GNOME Desktop Environment 

%end
%post

#enable SDDM
systemctl enable lightdm

#le cisco 
dnf config-manager --set-enabled fedora-cisco-openh264

%end
