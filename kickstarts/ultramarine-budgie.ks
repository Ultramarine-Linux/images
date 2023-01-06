#base fedora stuff

%include spins/budgie/budgie-base.ks


%packages
#x server
@base-x



#app groups because currently shit is empty
@firefox
@libreoffice
@hardware-support
bash-completion
bind-utils
btrfs-progs
psmisc

fuse

# Office
libreoffice

-@ GNOME Desktop Environment 

%end
