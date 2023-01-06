#base fedora stuff
%include spins/cutefish/cutefish-base.ks

%packages
#x server
@base-x



#app groups because currently shit is empty
@firefox
@libreoffice
@core
@hardware-support
bash-completion
bind-utils
btrfs-progs
psmisc

fuse

# Office
libreoffice-kf5

-gnome-session
-@ GNOME Desktop Environment 

%end
