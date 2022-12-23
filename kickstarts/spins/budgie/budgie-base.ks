%include ../../base/base.ks
%include budgie-packages.ks

services --disabled=gdm
%post

# set livesys session type
sed -i 's/^livesys_session=.*/livesys_session="budgie-desktop"/' /etc/sysconfig/livesys

cat >> /var/lib/livesys/livesys-session-extra << EOF
## set up lightdm autologin
sed -i 's/^#autologin-user=.*/autologin-user=liveuser/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user-timeout=.*/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf
# set Budgie as default session, otherwise login will fail
sed -i 's/^#user-session=.*/user-session=budgie-desktop/' /etc/lightdm/lightdm.conf

# set the default wallpaper
mkdir -p /home/liveuser/.local/share/applications

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

cp /etc/lightdm/lightdm.conf.d/50-ultramarine-lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf

%end
