#!/bin/bash -x

# set livesys session type
sed -i 's/^livesys_session=.*/livesys_session="budgie"/' /etc/sysconfig/livesys

cat >> /var/lib/livesys/livesys-session-extra << EOF
# Update installer icon
sed -i -e 's/Icon=org.fedoraproject.AnacondaInstaller/Icon=drive-harddisk/' /usr/share/applications/liveinst.desktop
sed -i -e 's/Icon=org.fedoraproject.AnacondaInstaller/Icon=drive-harddisk/' /home/liveuser/Desktop/liveinst.desktop

# allow anaconda to use system icon theme
sed -i -e 's/settings.set_property("gtk-icon-theme-name", "Adwaita")//' /usr/lib64/python3.12/site-packages/pyanaconda/ui/gui/__init__.py
EOF
