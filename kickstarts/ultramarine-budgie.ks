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
libreoffice-kf5

-@ GNOME Desktop Environment 

%end
%post

#le cisco 
dnf config-manager --set-enabled fedora-cisco-openh264

%end
%post --nochroot
if [ ! -z "$INSTALL_ROOT" ]; then eval INSTROOT="${INSTALL_ROOT}" ; else eval INSTROOT="/mnt/sysimage"; fi

SPIN=budgie

echo =========LAPIS BUILD SYSTEM SCRIPT========
echo
echo "Running on $PWD"
echo =========Merging Product folders========
echo "Preparing temporary directory" && mkdir -p /tmp/lapis
echo "Copying base root" && cp -avx files/base/product/ /tmp/lapis
echo "Merging with spin-specific changes" && cp -avx files/$SPIN/product /tmp/lapis
#Inject product.img into the ISO
echo "Injecting changes into root" && cp -avx /tmp/lapis/product/./* $INSTROOT/
%end