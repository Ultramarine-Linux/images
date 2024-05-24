#!/bin/bash -x

cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/startxfce4
DISPLAYMANAGER=/usr/sbin/lightdm
EOF

# set livesys session type
sed -i 's/^livesys_session=.*/livesys_session="xfce"/' /etc/sysconfig/livesys

cat >>/var/lib/livesys/livesys-session-extra <<ALLEOF
# Use our XFCE panel config
cp /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml /home/liveuser/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
ALLEOF
