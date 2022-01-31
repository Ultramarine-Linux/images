#base fedora stuff

%include spins/budgie/budgie-base.ks


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
libreoffice
@^flagship-product-environment
-@ GNOME Desktop Environment 

%end
%post

# Inject a dummy .buildstamp so Anaconda doesn't complain
cat << EOF > /.buildstamp
[Main]
Product=Ultramarine
Version=35
BugURL=None
IsFinal=true
UUID=202112022224.x86_64
Variant=Flagship
[Compose]
Lorax=35.7-1
EOF


#le cisco 
dnf config-manager --set-enabled fedora-cisco-openh264

%end