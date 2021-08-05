

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
sed -i "s/^#Session=.*/Session=\cyber-xsession/" /etc/sddm.conf
else
cat > /etc/sddm.conf << SDDM_EOF
[Autologin]
User=liveuser
Session=cyber-session
SDDM_EOF
fi

# add liveinst.desktop to favorites menu
mkdir -p /home/liveuser/.config/
cat > /home/liveuser/.config/kickoffrc << MENU_EOF
[Favorites]
FavoriteURLs=/usr/share/applications/firefox.desktop,/usr/share/applications/cyber-settings.desktop,/usr/share/applications/cyber-terminal.desktop,/usr/share/applications/liveinst.desktop
MENU_EOF

# show liveinst.desktop on desktop and in menu
sed -i 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
# set executable bit disable KDE security warning
chmod +x /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/Desktop
cp -a /usr/share/applications/liveinst.desktop /home/liveuser/Desktop/

#live installer on autostart
cp -a /usr/share/applications/liveinst.desktop /home/liveuser/.config/autostart/

# "Disable plasma-discover-notifier"
mkdir -p /home/liveuser/.config/autostart
cp -a /etc/xdg/autostart/org.kde.discover.notifier.desktop /home/liveuser/.config/autostart/
echo 'Hidden=true' >> /home/liveuser/.config/autostart/org.kde.discover.notifier.desktop


# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/

EOF

%end
