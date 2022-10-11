%include ../../base/base.ks
%include pantheon-packages.ks

services --disabled=gdm
%post

# create /etc/sysconfig/desktop (needed for installation)

cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/gnome-session --builtin --session=pantheon
DISPLAYMANAGER=/usr/sbin/lightdm
EOF

#cp /etc/lightdm/lightdm.conf.d/50-ultramarine-lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf

cat >> /etc/rc.d/init.d/livesys << EOF

## set up lightdm autologin
sed -i 's/^#autologin-user=.*/autologin-user=liveuser/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user-timeout=.*/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf
#
# set Pantheon as default session, otherwise login will fail
sed -i 's/^#user-session=.*/user-session=pantheon/' /etc/lightdm/lightdm.conf


# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/Desktop
cp /usr/share/applications/liveinst.desktop /home/liveuser/Desktop

# and mark it as executable
chmod +x /home/liveuser/Desktop/liveinst.desktop

# this goes at the end after all other changes.
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

EOF

%end


