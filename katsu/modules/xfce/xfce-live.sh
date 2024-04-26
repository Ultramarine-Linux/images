#!/bin/bash -x

systemctl disable gdm || true  # might fail

# set livesys session type
sed -i 's/^livesys_session=.*/livesys_session="xfce"/' /etc/sysconfig/livesys

glib-compile-schemas /usr/share/glib-2.0/schemas/

cat >> /var/lib/livesys/livesys-session-extra << EOF
## set up lightdm autologin
sed -i 's/^#autologin-user=.*/autologin-user=liveuser/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user-timeout=.*/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf
# set Xfce as default session, otherwise login will fail
sed -i 's/^#user-session=.*/user-session=xfce/' /etc/lightdm/lightdm.conf

# Update installer icon
sed -i -e 's/Icon=org.fedoraproject.AnacondaInstaller/Icon=drive-harddisk/' /usr/share/applications/liveinst.desktop

# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/Desktop
cp /usr/share/applications/liveinst.desktop /home/liveuser/Desktop

# and mark it as executable
chmod +x /home/liveuser/Desktop/liveinst.desktop

# Install welcome screen
sed -i 's/Fedora/Ultramarine/g' /usr/share/anaconda/gnome/fedora-welcome
sed -i 's/fedora-logo-icon/ultramarine/g' /usr/share/anaconda/gnome/fedora-welcome

# allow anaconda to use system icon theme
sed -i -e 's/settings.set_property("gtk-icon-theme-name", "Adwaita")//' /usr/lib64/python3.12/site-packages/pyanaconda/ui/gui/__init__.py

glib-compile-schemas /usr/share/glib-2.0/schemas/

# this goes at the end after all other changes.
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser
EOF


popd || exit 1

cp /etc/lightdm/lightdm.conf.d/50-ultramarine-lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf

# Reinstall anaconda-core and anaconda-live to make sure we fix any localization issues

# dnf reinstall -y anaconda-core

dnf clean all
