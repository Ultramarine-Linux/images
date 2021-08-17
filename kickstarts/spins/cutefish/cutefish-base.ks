%include ../../base/base.ks
%include cutefish-packages.ks

%post


# set default GTK+ theme for root (see #683855, #689070, #808062)
#cat > /root/.gtkrc-2.0 << EOF
#include "/usr/share/themes/Adwaita/gtk-2.0/gtkrc"
#include "/etc/gtk-2.0/gtkrc"
#gtk-theme-name="Adwaita"
#EOF
#mkdir -p /root/.config/gtk-3.0
#cat > /root/.config/gtk-3.0/settings.ini << EOF
#[Settings]
#gtk-theme-name = Adwaita
#EOF

# add initscript
cat >> /etc/rc.d/init.d/livesys << ALLEOF

# set up autologin for user liveuser
if [ -f /etc/sddm.conf ]; then
sed -i 's/^#User=.*/User=liveuser/' /etc/sddm.conf
sed -i "s/^#Session=.*/Session=cutefish-xsession/" /etc/sddm.conf
sed -i "s/^#Current.*/Current=cutefish/" /etc/sddm.conf
else
cat > /etc/sddm.conf << SDDM_EOF
[Autologin]
User=liveuser
Session=cutefish-xsession
SDDM_EOF
fi


# set cutefish as default session, otherwise login will fail
#sed -i 's/^#user-session=.*/user-session=cutefish-xsession/' /etc/lightdm/lightdm.conf

##Configuration
#Create Liveuser dir
mkdir -p /home/liveuser/.config/cutefishos
mkdir -p /home/liveuser/.config/
#mkdir -p /home/liveuser/Downloads
#mkdir -p /home/liveuser/Documents
#mkdir -p /home/liveuser/Pictures
#mkdir -p /home/liveuser/Videos

#Edit cutefish Configuration
touch /home/liveuser/.config/cutefishos/theme.conf
cat << 'EOF' > /home/liveuser/.config/cutefishos/theme.conf
[General]
AccentColor=0
DarkMode=false
DarkModeDimsWallpaer=false
PixelRatio=1
Wallpaper=/usr/share/backgrounds/ultramarine-linux/default/blue-ocean.jpg
EOF

#cutefish Dock
touch /home/liveuser/.config/cutefishos/dock_pinned.conf
cat << 'EOF' > /home/liveuser/.config/cutefishos/dock_pinned.conf

[Firefox]
DesktopPath=/usr/share/applications/firefox.desktop
Exec=firefox
IconName=firefox
Index=0
visibleName=Firefox
 
[cutefish-filemanager]
DesktopPath=/usr/share/applications/cutefish-filemanager.desktop
Exec=cutefish-fm
IconName=file-system-manager
Index=3
visibleName=File Manager
 
[cutefish-terminal]
DesktopPath=/usr/share/applications/cutefish-terminal.desktop
Exec=cutefish-terminal
IconName=utilities-terminal
Index=1
visibleName=Terminal
EOF

#Autostart Installer
mkdir -p /home/liveuser/.config/autostart/
cp /usr/share/anaconda/gnome/fedora-welcome.desktop /home/liveuser/.config/autostart/
chmod +x /home/liveuser/.config/autostart/fedora-welcome.desktop


#cutefish Dock
touch /home/liveuser/.config/cutefishos/dock_pinned.conf
cat << 'EOF' > /home/liveuser/.config/cutefishos/dock_pinned.conf
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
 
[cutefish-filemanager]
DesktopPath=/usr/share/applications/cutefish-filemanager.desktop
Exec=cutefish-fm
IconName=file-system-manager
Index=3
visibleName=File Manager
 
[cutefish-terminal]
DesktopPath=/usr/share/applications/cutefish-terminal.desktop
Exec=cutefish-terminal
IconName=utilities-terminal
Index=1
visibleName=Terminal
EOF



#Set Text Editor for all users
xdg-mime default cutefish-edit.desktop text/plain


# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

ALLEOF

##add skeleton home


##Configuration
#Create Liveuser dir
mkdir -p /etc/skel/.config/cutefishos
mkdir -p /etc/skel/.config/
#mkdir -p /etc/skel/Downloads
#mkdir -p /etc/skel/Documents
#mkdir -p /etc/skel/Pictures
#mkdir -p /etc/skel/Videos

#Edit cutefish Configuration
touch /etc/skel/.config/cutefishos/theme.conf
cat << 'EOF' > /etc/skel/.config/cutefishos/theme.conf
[General]
AccentColor=0
DarkMode=false
DarkModeDimsWallpaer=false
PixelRatio=1
Wallpaper=/usr/share/backgrounds/ultramarine-linux/default/blue-ocean.jpg
EOF

#cutefish Dock
touch /etc/skel/.config/cutefishos/dock_pinned.conf
cat << 'EOF' > /etc/skel/.config/cutefishos/dock_pinned.conf

[Firefox]
DesktopPath=/usr/share/applications/firefox.desktop
Exec=firefox
IconName=firefox
Index=0
visibleName=Firefox
 
[cutefish-fm]
DesktopPath=/usr/share/applications/cutefish-fm.desktop
Exec=cutefish-fm
IconName=file-system-manager
Index=3
visibleName=File Manager
 
[cutefish-terminal]
DesktopPath=/usr/share/applications/cutefish-terminal.desktop
Exec=cutefish-terminal
IconName=utilities-terminal
Index=1
visibleName=Terminal
EOF


%end
