#!/bin/bash -x
systemctl disable -f gdm.service
systemctl enable -f lightdm.service
# create /etc/sysconfig/desktop (needed for installation)

cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/gnome-session --builtin --session=pantheon
DISPLAYMANAGER=/usr/sbin/lightdm
EOF

cat >> /var/lib/livesys/livesys-session-extra << EOF

## set up lightdm autologin
sed -i 's/^#autologin-user=.*/autologin-user=liveuser/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user-timeout=.*/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf
#
# set Pantheon as default session, otherwise login will fail
sed -i 's/^#user-session=.*/user-session=pantheon/' /etc/lightdm/lightdm.conf

# set the default wallpaper
gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/ultramarine-linux/39/foresty-skies-l.png
mkdir -p /home/liveuser/.local/share/applications

# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/Desktop
cp /usr/share/applications/liveinst.desktop /home/liveuser/Desktop

# and mark it as executable
chmod +x /home/liveuser/Desktop/liveinst.desktop

# allow anaconda to use system icon theme
sed -i -e 's/settings.set_property("gtk-icon-theme-name", "Adwaita")//' /usr/lib64/python3.11/site-packages/pyanaconda/ui/gui/__init__.py

# this goes at the end after all other changes.
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

EOF