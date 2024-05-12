#!/bin/bash -x

# set default GTK+ theme for root (see #683855, #689070, #808062)
cat >/root/.gtkrc-2.0 <<EOF
include "/usr/share/themes/Adwaita/gtk-2.0/gtkrc"
include "/etc/gtk-2.0/gtkrc"
gtk-theme-name="Adwaita"
EOF
mkdir -p /root/.config/gtk-3.0
cat >/root/.config/gtk-3.0/settings.ini <<EOF
[Settings]
gtk-theme-name = Adwaita
EOF

cat >>/var/lib/livesys/livesys-session-extra <<ALLEOF
# Install welcome screen
sed -i 's/Fedora/Ultramarine/g' /usr/share/anaconda/gnome/fedora-welcome
ALLEOF
