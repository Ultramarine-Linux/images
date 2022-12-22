%include ../../base/base.ks
%include budgie-packages.ks

services --disabled=gdm
%post

# set livesys session type
sed -i 's/^livesys_session=.*/livesys_session="budgie-desktop"/' /etc/sysconfig/livesys

cat >> /var/lib/livesys/livesys-session-extra << EOF
# display the installer shortcut
sed -i 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop

# set the default wallpaper
mkdir -p /home/liveuser/.local/share/applications


desktop-file-install /usr/share/anaconda/gnome/fedora-welcome.desktop --dirs /home/liveuser/.config/autostart/

EOF


%end
