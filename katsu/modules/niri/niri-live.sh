#!/bin/bash -x
set -euo pipefail

# livesys has no niri session yet (livecd-tools/livesys-scripts#39)
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

# prevent keyring create password popup
mkdir -p /home/liveuser/.local/share/keyrings
cat >/home/liveuser/.local/share/keyrings/login.keyring <<EOF
[keyring]
display-name=login
ctime=0
mtime=0
lock-on-idle=false
lock-after=false
EOF
echo login >/home/liveuser/.local/share/keyrings/default
chmod 700 /home/liveuser/.local/share/keyrings

# prevent noctalia from showing a lockscreen
cat >/home/liveuser/.config/noctalia/zz-live.toml <<EOF
[lockscreen]
enabled = false
EOF

# fix file permissions or keyring gets angry
chown -R liveuser:liveuser /home/liveuser/.local /home/liveuser/.config/noctalia

# no update downloads in the live session
cat >>/usr/share/glib-2.0/schemas/org.gnome.software.gschema.override <<EOF
[org.gnome.software]
allow-updates=false
download-updates=false
EOF
rm -f /etc/xdg/autostart/org.gnome.Software.desktop
glib-compile-schemas /usr/share/glib-2.0/schemas

ALLEOF
