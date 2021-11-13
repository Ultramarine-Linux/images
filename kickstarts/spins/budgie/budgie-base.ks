%include ../../base/base.ks
%include budgie-packages.ks

services --disabled=gdm
%post

# create /etc/sysconfig/desktop (needed for installation)

cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/budgie-desktop
DISPLAYMANAGER=/usr/sbin/lightdm
EOF

cat > /home/liveuser/.config/autostart/fedora-welcome.desktop << EOF
[Desktop Entry]
Name=Welcome to Fedora
Exec=/usr/share/anaconda/gnome/fedora-welcome
Terminal=false
Type=Application
StartupNotify=true
NoDisplay=true
X-GNOME-Autostart-enabled=true
EOF

cat >> /etc/rc.d/init.d/livesys << EOF

## set up lightdm autologin
sed -i 's/^#autologin-user=.*/autologin-user=liveuser/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user-timeout=.*/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf
sed -i 's/^#show-language-selector=.*/show-language-selector=true/' /etc/lightdm/lightdm-gtk-greeter.conf
#
# set Budgie as default session, otherwise login will fail
sed -i 's/^#user-session=.*/user-session=budgie-desktop/' /etc/lightdm/lightdm.conf
cat > /etc/lightdm/lightdm.conf.d/00-live-session.conf <<DMEOF
[Seat*]
autologin-user=liveuser
user-session=budgie-desktop
DMEOF


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


