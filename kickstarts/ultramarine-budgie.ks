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
microcode_ctl
psmisc

fuse

# Office
libreoffice

-@ GNOME Desktop Environment 

%end
%post

# Inject a dummy .buildstamp so Anaconda doesn't complain
cat << EOF > /.buildstamp
[Main]
Product=Ultramarine
Version=36
BugURL=None
IsFinal=true
UUID=202112022224.x86_64
Variant=Flagship
[Compose]
Lorax=35.7-1
EOF

%end