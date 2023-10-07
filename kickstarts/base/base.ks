# fedora-live-base.ks
#
# Defines the basics for all kickstarts in the fedora-live branch
# Does not include package selection (other then mandatory)
# Does not include localization packages or configuration
#
# Does includes "default" language configuration (kickstarts including
# this template can override these settings)

#load custom files
%include desktop.ks

lang en_US.UTF-8
keyboard 'us'
timezone US/Eastern
selinux --enforcing
firewall --enabled --service=mdns
xconfig --startxonboot
zerombr
clearpart --all
part / --size 8192 --fstype ext4
services --enabled=NetworkManager,ModemManager --disabled=systemd-networkd,chrony-wait,NetworkManager-wait-online
network --bootproto=dhcp --device=link --activate
rootpw --lock --iscrypted locked
shutdown

%include base-repo.ks
%include additional-repos.ks

%packages --instLangs all
@hardware-support
@printing
pam
# Explicitly specified here:
# <notting> walters: because otherwise dependency loops cause yum issues.
kernel
kernel-modules
kernel-modules-extra
# We are adding kernel headers so users can easily install akmod packages
kernel-devel
kernel-headers
kernel-core

-fedora-bookmarks

# This was added a while ago, I think it falls into the category of
# "Diagnosis/recovery tool useful from a Live OS image".  Leaving this untouched
# for now.
#memtest86+

# A11y

# Please think of the blind

orca
espeak-ng
# brltty
# brltty-espeak-ng
speech-dispatcher-espeak-ng
brltty-minimal

# Remove initial-setup so we don't run it on boot
-initial-setup*

# anaconda needs the locales available to run for different locales
glibc-all-langpacks

# The point of a live image is to install
anaconda
anaconda-core
anaconda-install-env-deps
anaconda-live
@anaconda-tools
# Anaconda has a weak dep on this and we don't want it on livecds, see
# https://fedoraproject.org/wiki/Changes/RemoveDeviceMapperMultipathFromWorkstationLiveCD
-fcoe-utils
-device-mapper-multipath

# Need aajohan-comfortaa-fonts for the SVG rnotes images
aajohan-comfortaa-fonts

julietaula-montserrat-alternates-fonts
julietaula-montserrat-fonts

# Without this, initramfs generation during live image creation fails: #1242586
dracut-config-generic
dracut-live


##Exclude Fedora Branding
-fedora-release*
-fedora-logos*
-generic-release*
ultramarine-release-common
ultramarine-release
ultramarine-logos*
ultramarine-repos
ultramarine-backgrounds


# Unneeded packages
-gnome-boxes

# no longer in @core since 2018-10, but needed for livesys script
# We need to keep this for now, since pantheon and plasma require our own scripts
# These should eventually be moved to a seperate package, instead of this hack - @lleyton
initscripts
chkconfig


gjs

# fancy starship prompt
starship
zsh

# chsh
util-linux-user

livesys-scripts

%end


%post
# Enable livesys services
systemctl enable livesys.service
systemctl enable livesys-late.service

# enable tmpfs for /tmp
systemctl enable tmp.mount

# make it so that we don't do writing to the overlay for things which
# are just tmpdirs/caches
# note https://bugzilla.redhat.com/show_bug.cgi?id=1135475
cat >> /etc/fstab << EOF
vartmp   /var/tmp    tmpfs   defaults   0  0
EOF

# work around for poor key import UI in PackageKit
rm -f /var/lib/rpm/__db*
echo "Packages within this LiveCD"
rpm -qa --qf '%{size}\t%{name}-%{version}-%{release}.%{arch}\n' |sort -rn
# Note that running rpm recreates the rpm db files which aren't needed or wanted
rm -f /var/lib/rpm/__db*

# go ahead and pre-make the man -k cache (#455968)
/usr/bin/mandb -c

# make sure there aren't core files lying around
rm -f /core*

# remove random seed, the newly installed instance should make it's own
rm -f /var/lib/systemd/random-seed

# convince readahead not to collect
# FIXME: for systemd

echo 'File created by kickstart. See systemd-update-done.service(8).' \
    | tee /etc/.updated >/var/.updated

# Drop the rescue kernel and initramfs, we don't need them on the live media itself.
# See bug 1317709
rm -f /boot/*-rescue*

# Disable network service here, as doing it in the services line
# fails due to RHBZ #1369794
systemctl disable network
systemctl disable systemd-networkd
systemctl disable systemd-networkd-wait-online
systemctl disable openvpn-client@\*.service
systemctl disable openvpn-server@\*.service

# Remove machine-id on pre generated images
rm -f /etc/machine-id
touch /etc/machine-id
%end


%post --nochroot
cp -P --remove-destination /etc/resolv.conf /mnt/sysimage/etc/resolv.conf
%end

%post --erroronfail
dnf reinstall -y anaconda-core anaconda-live
rm -f /etc/resolv.conf
dnf clean all
%end

%post --nochroot
# For livecd-creator builds only (lorax/livemedia-creator handles this directly)
if [ -n "$LIVE_ROOT" ]; then
    cp "$INSTALL_ROOT"/usr/share/licenses/*-release-common/* "$LIVE_ROOT/"

    # only installed on x86, x86_64
    if [ -f /usr/bin/livecd-iso-to-disk ]; then
        mkdir -p "$LIVE_ROOT/LiveOS"
        cp /usr/bin/livecd-iso-to-disk "$LIVE_ROOT/LiveOS"
    fi
fi

%end
