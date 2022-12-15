# base-remix.ks
#
# Adds extra repos for software that the Fedora Project doesn't want to ship.

# Extra repositories
repo --name="rpmfusion-free-release" --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-$releasever&arch=$basearch
repo --name="rpmfusion-free-release-tainted" --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-updates-released-$releasever&arch=$basearch
repo --name="rpmfusion-nonfree-release" --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-$releasever&arch=$basearch
repo --name="rpmfusion-nonfree-release-tainted" --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-updates-released-$releasever&arch=$basearch
repo --name="fedora-cisco-openh264" --baseurl=https://codecs.fedoraproject.org/openh264/$releasever/$basearch/os/
%packages

# RPM Fusion repositories
rpmfusion-free-release
rpmfusion-free-release-tainted
rpmfusion-nonfree-release
rpmfusion-nonfree-release-tainted

# Appstream data
rpmfusion-*-appstream-data

# Multimedia
gstreamer1-libav
gstreamer1-vaapi
gstreamer1-plugins-bad-freeworld
gstreamer1-plugins-ugly
# Tools
unrar

%end

%post

# Enable Cisco Open H.264 repository
dnf config-manager --set-enabled fedora-cisco-openh264

%end
