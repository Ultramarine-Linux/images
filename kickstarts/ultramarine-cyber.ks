#base fedora stuff

%include additional-repos.ks
%include cyber-base.ks

#cyber-desktop repo
repo --name "copr:copr.fedorainfracloud.org:cappyishihara:cyber-desktop" --install --baseurl https://download.copr.fedorainfracloud.org/results/cappyishihara/cyber-desktop/fedora-$releasever-$basearch/

%packages
#x server
@base-x

#install cyber desktop
cyber-desktop
meuikit-devel

#SDDM
sddm

#app groups because currently shit is empty
@firefox
@libreoffice
@admin-tools

fuse
mediawriter

# Office
libreoffice-kf5

-gnome*

%end
%post
systemctl disable gdm
systemctl enable sddm
%end
