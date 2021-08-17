#base fedora stuff

%include spins/cyber/cyber-base.ks

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

#le cisco 
dnf config-manager --set-enabled fedora-cisco-openh264

%end
%post --nochroot
##Build and inject Product.img
echo =========LAPIS BUILD SYSTEM SCRIPT========
echo
echo "Running on $PWD"
echo =========Merging Product folders========
echo "Preparing temporary directory" && mkdir -p /tmp/lapis
echo "Copying base root" && cp -avx files/base/product/ /tmp/lapis
echo "Merging with spin-specific changes" && cp -avx files/cyber/product /tmp/lapis
#Inject product.img into the ISO
echo "Injecting changes into root" && cp -avx /tmp/lapis/product/./* $INSTALL_ROOT/
%end