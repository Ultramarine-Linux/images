%include ../../base/base.ks
%include cyber-packages.ks

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

#Autostart Installer
mkdir -p /home/liveuser/.config/autostart/
cp /usr/share/anaconda/gnome/fedora-welcome.desktop /home/liveuser/.config/autostart/
chmod +x /home/liveuser/.config/autostart/fedora-welcome.desktop


# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

ALLEOF


%end
