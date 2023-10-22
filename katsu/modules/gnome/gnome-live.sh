#!/bin/bash -x

sed -i 's/^livesys_session=.*/livesys_session="gnome"/' /etc/sysconfig/livesys
sed -i 's/Fedora/Ultramarine/g' /usr/share/anaconda/gnome/fedora-welcome
sed -i 's/Fedora/Ultramarine/g' /usr/share/applications/org.fedoraproject.welcome-screen.desktop
sed -i 's/Fedora/Ultramarine/g' /usr/share/anaconda/gnome/org.fedoraproject.welcome-screen.desktop
