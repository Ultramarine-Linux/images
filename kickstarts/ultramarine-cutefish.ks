#base fedora stuff
%include spins/cutefish/cutefish-base.ks

#cyber-desktop repo
repo --name "copr:copr.fedorainfracloud.org:rmnscnce:cutefish-desktop" --baseurl https://download.copr.fedorainfracloud.org/results/rmnscnce/cutefish-desktop/fedora-$releasever-$basearch/


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

#le cisco 
dnf config-manager --set-enabled fedora-cisco-openh264

%end

