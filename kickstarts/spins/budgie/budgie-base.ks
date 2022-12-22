%include ../../base/base.ks
%include budgie-packages.ks

services --disabled=gdm
%post

# set livesys session type
sed -i 's/^livesys_session=.*/livesys_session="budgie-desktop"/' /etc/sysconfig/livesys

cat >> /var/lib/livesys/livesys-session-extra << EOF
## set up lightdm autologin
sed -i 's/^#autologin-user=.*/autologin-user=liveuser/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user-timeout=.*/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf
# set Budgie as default session, otherwise login will fail
sed -i 's/^#user-session=.*/user-session=budgie-desktop/' /etc/lightdm/lightdm.conf

# display the installer shortcut
sed -i 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop

# set the default wallpaper
mkdir -p /home/liveuser/.local/share/applications
EOF


%end
