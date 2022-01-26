%include ../../base/base.ks
%include cutefish-packages.ks

%post

# add initscript
cat >> /etc/rc.d/init.d/livesys << ALLEOF

# set up autologin for user liveuser
if [ -f /etc/sddm.conf ]; then
sed -i 's/^#User=.*/User=liveuser/' /etc/sddm.conf
sed -i "s/^#Session=.*/Session=cutefish-xsession/" /etc/sddm.conf
sed -i "s/^#Current.*/Current=cutefish/" /etc/sddm.conf
# add InputMethod= to general section if not exists
if ! grep -q "^InputMethod=" /etc/sddm.conf; then
# find [General] section and add InputMethod= to it
sed -i '/^\[General\]/a\InputMethod=' /etc/sddm.conf
fi
else
cat > /etc/sddm.conf << SDDM_EOF
[Autologin]
User=liveuser
Session=cutefish-xsession
[General]
InputMethod=
SDDM_EOF
fi

#Autostart Installer
mkdir -p /home/liveuser/.config/autostart/
cp /usr/share/anaconda/gnome/fedora-welcome.desktop /home/liveuser/.config/autostart/
chmod +x /home/liveuser/.config/autostart/fedora-welcome.desktop

chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser
ALLEOF


%end
