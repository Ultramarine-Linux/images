#!/bin/bash -x
set -euo pipefail

cat >>/var/lib/livesys/livesys-session-extra <<'ALLEOF'
# log straight into niri as liveuser
cat >>/etc/greetd/ultramarine-niri.toml <<EOF

[initial_session]
command = "niri-session"
user = "liveuser"
EOF

# liveuser has no password, let the greeter log back in after a logout
if ! grep -q '^\[auth\]' /var/lib/noctalia-greeter/greeter.toml; then
    printf '\n[auth]\nallow_empty_password = true\n' >>/var/lib/noctalia-greeter/greeter.toml
fi

# dont lock the screen on idle
sed -i '/^\s*\[idle\.behavior\.lock\]/,/^\s*\[/s/enabled = true/enabled = false/' \
    /home/liveuser/.config/noctalia/config.toml

# no update downloads in the live session
cat >>/usr/share/glib-2.0/schemas/org.gnome.software.gschema.override <<EOF
[org.gnome.software]
allow-updates=false
download-updates=false
EOF
rm -f /etc/xdg/autostart/org.gnome.Software.desktop
glib-compile-schemas /usr/share/glib-2.0/schemas
ALLEOF
