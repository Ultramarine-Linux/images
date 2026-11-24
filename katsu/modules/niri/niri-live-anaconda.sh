#!/bin/bash -x
set -euo pipefail

cat >>/var/lib/livesys/livesys-session-extra <<'ALLEOF'
sed -i 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop

mkdir -p /home/liveuser/.config/noctalia
cat >/home/liveuser/.config/noctalia/zz-live-install.toml <<'EOF'
[desktop_widgets]
enabled = true

[desktop_widgets.widget.live_install]
type = "button"
cx = 160.0
cy = 160.0

[desktop_widgets.widget.live_install.settings]
glyph   = "download"
label   = "Install to Hard Drive"
command = "liveinst"
variant = "primary"
EOF
chown -R liveuser:liveuser /home/liveuser/.config

cat >/usr/share/polkit-1/rules.d/20-livesys-niri.rules <<'EOF'
polkit.addRule(function(action, subject) {
    if (!subject.local) return undefined;
    if (subject.user !== 'liveuser') return undefined;
    if (action.id.indexOf('org.fedoraproject.pkexec.liveinst') !== 0) return undefined;
    return 'yes';
});
EOF
ALLEOF
