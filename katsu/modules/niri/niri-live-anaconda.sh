#!/bin/bash -x
set -euo pipefail

cat >>/var/lib/livesys/livesys-session-extra <<'ALLEOF'
# install button on the bar, right after the launcher
sed -i 's/^\(\s*start = \[ "launcher",\)/\1 "live-install",/' \
    /home/liveuser/.config/noctalia/config.toml
cat >>/home/liveuser/.config/noctalia/config.toml <<EOF

[widget.live-install]
type = "custom_button"
glyph = "download"
label = "Install to Hard Drive"

[widget.live-install.actions]
left = "exec liveinst"
EOF

# let liveuser start the installer without a password
cat >/usr/share/polkit-1/rules.d/20-livesys-niri.rules <<'EOF'
polkit.addRule(function(action, subject) {
    if (!subject.local) return undefined;
    if (subject.user !== 'liveuser') return undefined;
    if (action.id.indexOf('org.fedoraproject.pkexec.liveinst') !== 0) return undefined;
    return 'yes';
});
EOF
ALLEOF
