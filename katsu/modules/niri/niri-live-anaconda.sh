#!/bin/bash -x
set -euo pipefail

# "Install to Hard Drive"
cat >>/var/lib/livesys/livesys-session-extra <<'ALLEOF'
# "Install to Hard Drive" in the launcher
sed -i 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop

# and an install button on the bar, next to the launcher
sed -i 's/^\(\s*start = \[ "launcher",\)/\1 "live-install",/' \
    /home/liveuser/.config/noctalia/config.toml
cat >>/home/liveuser/.config/noctalia/config.toml <<EOF

[widget.live-install]
type = "custom_button"
glyph = "download"
label = "Install Ultramarine"
tooltip = "Install Ultramarine to this computer"

[widget.live-install.actions]
left = "exec liveinst"
EOF

# make liveuser able to start the installer without password
cat >/usr/share/polkit-1/rules.d/20-livesys-niri.rules <<EOF
polkit.addRule(function(action, subject) {
    if (!subject.local)
        return undefined;
    if (subject.user !== 'liveuser')
        return undefined;
    if (action.id.indexOf('org.fedoraproject.pkexec.liveinst') !== 0)
        return undefined;
    return 'yes';
});
EOF
ALLEOF
