%include ../../base/base.ks
%include plasma-packages.ks

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
cat >> /var/lib/livesys/livesys-session-extra << ALLEOF

# are we *not* able to use wayland sessions?
if strstr "\`cat /proc/cmdline\`" nomodeset ; then
PLASMA_SESSION_FILE="plasmax11.desktop"
else
PLASMA_SESSION_FILE="plasma.desktop"
fi

# set up autologin for user liveuser
if [ -f /etc/sddm.conf ]; then
sed -i 's/^#User=.*/User=liveuser/' /etc/sddm.conf
sed -i "s/^#Session=.*/Session=\${PLASMA_SESSION_FILE}/" /etc/sddm.conf
else
cat > /etc/sddm.conf << SDDM_EOF
[Autologin]
User=liveuser
Session=\${PLASMA_SESSION_FILE}
SDDM_EOF
fi

# add liveinst.desktop to favorites menu
mkdir -p /home/liveuser/.config/
cat > /home/liveuser/.config/kickoffrc << MENU_EOF
[Favorites]
FavoriteURLs=/usr/share/applications/firefox.desktop,/usr/share/applications/org.kde.dolphin.desktop,/usr/share/applications/systemsettings.desktop,/usr/share/applications/org.kde.konsole.desktop,/usr/share/applications/liveinst.desktop
MENU_EOF

# show liveinst.desktop on desktop and in menu
sed -i 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
# set executable bit disable KDE security warning
chmod +x /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/Desktop
cp -a /usr/share/applications/liveinst.desktop /home/liveuser/Desktop/

# Set akonadi backend
mkdir -p /home/liveuser/.config/akonadi
cat > /home/liveuser/.config/akonadi/akonadiserverrc << AKONADI_EOF
[%General]
Driver=QSQLITE3
AKONADI_EOF

# "Disable plasma-discover-notifier"
mkdir -p /home/liveuser/.config/autostart
cp -a /etc/xdg/autostart/org.kde.discover.notifier.desktop /home/liveuser/.config/autostart/
echo 'Hidden=true' >> /home/liveuser/.config/autostart/org.kde.discover.notifier.desktop

# Disable baloo
cat > /home/liveuser/.config/baloofilerc << BALOO_EOF
[Basic Settings]
Indexing-Enabled=false
BALOO_EOF

# Disable kres-migrator
cat > /home/liveuser/.kde/share/config/kres-migratorrc << KRES_EOF
[Migration]
Enabled=false
KRES_EOF

# Disable kwallet migrator
cat > /home/liveuser/.config/kwalletrc << KWALLET_EOL
[Migration]
alreadyMigrated=true
KWALLET_EOL

# Disable automount of 'known' devices
# https://bugzilla.redhat.com/show_bug.cgi?id=2073708
cat > /home/liveuser/.config/kded_device_automounterrc << AUTOMOUNTER_EOF
[General]
AutomountEnabled=false
AutomountOnLogin=false
AutomountOnPlugin=false
AUTOMOUNTER_EOF

# Copy latte dock config
echo "Copying latte dock config"
mkdir -p /home/liveuser/.config/
cp -av /etc/skel/.config/lattedockrc /home/liveuser/.config/lattedockrc

# copy latte startup file
cp -av /etc/xdg/autostart/org.kde.latte-dock.desktop /home/liveuser/.config/autostart/

# Make it use the Ultramarine layout
sed -i 's/Exec=.*/Exec=/usr/bin/latte-dock --layout=Ultramarine/' /home/liveuser/.config/autostart/org.kde.latte-dock.desktop



# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/

ALLEOF


%end
