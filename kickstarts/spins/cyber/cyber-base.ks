%include ../../base/base.ks
%include cyber-packages.ks

%post
##For some arcane reason, the new build factoring process does not work on this one script, so bear with me for this one.

# set default GTK+ theme for root (see #683855, #689070, #808062)
cat > /root/.gtkrc-2.0 << EOF
include "/usr/share/themes/Flat-Remix-GTK-Blue/gtk-2.0/gtkrc"
include "/etc/gtk-2.0/gtkrc"
gtk-theme-name="Flat-Remix-GTK-Blue"
EOF
mkdir -p /root/.config/gtk-3.0
cat > /root/.config/gtk-3.0/settings.ini << EOF
[Settings]
gtk-theme-name = Flat-Remix-GTK-Blue
EOF

# add initscript
cat >> /etc/rc.d/init.d/livesys << ALLEOF

# set up autologin for user liveuser
if [ -f /etc/sddm.conf ]; then
sed -i 's/^#User=.*/User=liveuser/' /etc/sddm.conf
sed -i "s/^#Session=.*/Session=cyber-xsession/" /etc/sddm.conf
else
cat > /etc/sddm.conf << SDDM_EOF
[Autologin]
User=liveuser
Session=cyber-xsession
SDDM_EOF
fi

cat > /home/liveuser/.gtkrc-2.0 << EOF
include "/usr/share/themes/Flat-Remix-GTK-Blue/gtk-2.0/gtkrc"
include "/etc/gtk-2.0/gtkrc"
gtk-theme-name="Flat-Remix-GTK-Blue"
EOF
mkdir -p /home/liveuser/.config/gtk-3.0
cat > /home/liveuser/.config/gtk-3.0/settings.ini << EOF
[Settings]
gtk-theme-name = Flat-Remix-GTK-Blue
EOF


# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

ALLEOF

##add skeleton home


##Configuration
#Create Liveuser dir
mkdir -p /etc/skel/.config/cyberos
mkdir -p /etc/skel/.config/
mkdir -p /etc/skel/Downloads
mkdir -p /etc/skel/Documents
mkdir -p /etc/skel/Pictures
mkdir -p /etc/skel/Videos
%end
