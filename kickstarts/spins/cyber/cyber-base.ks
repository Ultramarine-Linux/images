%include ../../base/base.ks
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
cat >> /etc/rc.d/init.d/livesys << ALLEOF

# set up lightdm autologin
sed -i 's/^#autologin-user=.*/autologin-user=liveuser/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user-timeout=.*/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf
sed -i 's/^#show-language-selector=.*/show-language-selector=true/' /etc/lightdm/lightdm-gtk-greeter.conf


# set cyber as default session, otherwise login will fail
sed -i 's/^#user-session=.*/user-session=cyber-xsession/' /etc/lightdm/lightdm.conf

##Configuration
#Create Liveuser dir
mkdir -p /home/liveuser/.config/cyberos
mkdir -p /home/liveuser/.config/
#mkdir -p /home/liveuser/Downloads
#mkdir -p /home/liveuser/Documents
#mkdir -p /home/liveuser/Pictures
#mkdir -p /home/liveuser/Videos

#Edit Cyber Configuration
touch /home/liveuser/.config/cyberos/theme.conf
cat << 'EOF' > /home/liveuser/.config/cyberos/theme.conf
[General]
AccentColor=0
DarkMode=false
DarkModeDimsWallpaer=false
PixelRatio=1
Wallpaper=/usr/share/backgrounds/ultramarine-linux/default/blue-ocean.jpg
EOF

#Cyber Dock
touch /home/liveuser/.config/cyberos/dock_pinned.conf
cat << 'EOF' > /home/liveuser/.config/cyberos/dock_pinned.conf

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

#Autostart Installer
mkdir /home/liveuser/.config/autostart/
cp /usr/share/anaconda/gnome/fedora-welcome.desktop /home/liveuser/.config/autostart/
chmod +x /home/liveuser/.config/autostart/fedora-welcome.desktop


#Cyber Dock
touch /home/liveuser/.config/cyberos/dock_pinned.conf
cat << 'EOF' > /home/liveuser/.config/cyberos/dock_pinned.conf
[Anaconda]
DesktopPath=
Exec=/usr/share/anaconda/gnome/fedora-welcome
IconName=anaconda
Index=2
visibleName=Install Ultramarine
 
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



#Set Text Editor for all users
xdg-mime default cyber-edit.desktop text/plain


# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

ALLEOF

##add skeleton home


##Configuration
#Create Liveuser dir
mkdir -p /etc/skel/.config/cyberos
mkdir -p /etc/skel/.config/
#mkdir -p /etc/skel/Downloads
#mkdir -p /etc/skel/Documents
#mkdir -p /etc/skel/Pictures
#mkdir -p /etc/skel/Videos

#Edit Cyber Configuration
touch /etc/skel/.config/cyberos/theme.conf
cat << 'EOF' > /etc/skel/.config/cyberos/theme.conf
[General]
AccentColor=0
DarkMode=false
DarkModeDimsWallpaer=false
PixelRatio=1
Wallpaper=/usr/share/backgrounds/ultramarine-linux/default/blue-ocean.jpg
EOF

#Cyber Dock
touch /etc/skel/.config/cyberos/dock_pinned.conf
cat << 'EOF' > /etc/skel/.config/cyberos/dock_pinned.conf

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


%end
