

%include base.ks
%include cyber-packages.ks

%post

# set default GTK+ theme for root (see #683855, #689070, #808062)
cat > /root/.gtkrc-2.0 << EOF
include "/usr/share/themes/Adwaita/gtk-2.0/gtkrc"
include "/etc/gtk-2.0/gtkrc"
gtk-theme-name="Adwaita"
EOF
mkdir -p /root/.config/gtk-3.0
cat > /root/.config/gtk-3.0/settings.ini << EOF
[Settings]
gtk-theme-name = Adwaita
EOF

# add initscript
cat >> /etc/rc.d/init.d/livesys << EOF


# set up autologin for user liveuser
if [ -f /etc/sddm.conf ]; then
sed -i 's/^#User=.*/User=liveuser/' /etc/sddm.conf
sed -i "s/^#Session=.*/Session=cyber-session/" /etc/sddm.conf
else
cat << 'EOF' > /etc/sddm.conf
[Autologin]
User=liveuser
Session=cyber-session
EOF

##Configuration

#Edit Cyber Configuration
touch /home/liveuser/.config/cyberos/themes.conf
cat << 'EOF' > /home/liveuser/.config/cyberos/themes.conf
[General]
AccentColor=0
DarkMode=false
DarkModeDimsWallpaer=false
PixelRatio=1
Wallpaper=/usr/share/backgrounds/images/default-16_9.png
EOF

#Cyber Dock
touch /home/liveuser/.config/cyberos/dock_pinned.conf
cat << 'EOF' > /home/liveuser/.config/cyberos/dock_pinned.conf
[Anaconda]
DesktopPath=
Exec=
IconName=anaconda
Index=2
visibleName=Anaconda Installer
 
[Firefox]
DesktopPath=/usr/share/applications/firefox.desktop
Exec=firefox
IconName=firefox
Index=0
visibleName=Firefox
 
[cyber-fm]
DesktopPath=/usr/share/applications/cyber-fm.desktop
Exec=cyber-fm
IconName=file-system-manager
Index=3
visibleName=File Manager
 
[cyber-terminal]
DesktopPath=/usr/share/applications/cyber-terminal.desktop
Exec=cyber-terminal
IconName=utilities-terminal
Index=1
visibleName=Terminal
EOF

# "Disable plasma-discover-notifier"
mkdir -p /home/liveuser/.config/autostart
cp -a /etc/xdg/autostart/org.kde.discover.notifier.desktop /home/liveuser/.config/autostart/
echo 'Hidden=true' >> /home/liveuser/.config/autostart/org.kde.discover.notifier.desktop

#Autostart Installer
touch /home/liveuser/.config/autostart/liveinst.desktop
cat << 'EOF' > /home/liveuser/.config/autostart/liveinst.desktop
[Desktop Entry]
Type=Application
Exec=/usr/bin/liveinst
Hidden=false
NoDisplay=false
Name=Install Ultramarine Linux
X-GNOME-Autostart-enabled=true
EOF


# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/

EOF

%end
