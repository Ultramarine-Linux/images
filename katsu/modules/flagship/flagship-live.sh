#!/bin/bash -x

systemctl disable gdm

# Remove Networkmanager Applet
echo "X-GNOME-Autostart-enabled=false" >> /etc/xdg/autostart/nm-applet.desktop
ln -sf /bin/true /usr/local/bin/nm-applet

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

# Install welcome screen autostart file
mkdir -p /home/liveuser/.config/autostart
cat > /home/liveuser/.config/autostart/ultramarine-welcome.desktop << EOA
[Desktop Entry]
Name=Welcome to Ultramarine
Comment=Welcome to Ultramarine
Exec=/usr/share/anaconda/gnome/fedora-welcome
Terminal=false
Type=Application
EOA



# allow anaconda to use system icon theme
sed -i -e 's/settings.set_property("gtk-icon-theme-name", "Adwaita")//' /usr/lib64/python3.11/site-packages/pyanaconda/ui/gui/__init__.py

# this goes at the end after all other changes.
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser
EOF

cp /etc/lightdm/lightdm.conf.d/50-ultramarine-lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf

# Reinstall anaconda-core and anaconda-live to make sure we fix any localization issues

# dnf reinstall -y anaconda-core

dnf clean all
