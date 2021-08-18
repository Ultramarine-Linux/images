%include ../../base/base.ks
%include cyber-packages.ks

%post
##For some arcane reason, the new build factoring process does not work on this one script, so bear with me for this one.

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

##Configuration
#Create Liveuser dir
mkdir -p /home/liveuser/.config/cyberos
mkdir -p /home/liveuser/.config/
mkdir -p /home/liveuser/Downloads
mkdir -p /home/liveuser/Documents
mkdir -p /home/liveuser/Pictures
mkdir -p /home/liveuser/Videos



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
mkdir -p /etc/skel/Downloads
mkdir -p /etc/skel/Documents
mkdir -p /etc/skel/Pictures
mkdir -p /etc/skel/Videos
%end
