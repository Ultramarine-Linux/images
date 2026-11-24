#!/bin/bash -x
set -euo pipefail

# initialize noctlia
# goes in sync.toml since greeter.toml would always override sync
if ! grep -q '^\[appearance' /var/lib/noctalia-greeter/sync.toml; then
    cat >> /var/lib/noctalia-greeter/sync.toml <<EOF

[appearance]
scheme = "Synced"
theme_mode = "dark"
font_family = "Noto Sans"
hide_logo = "true"

[appearance.palette]
primary = "#3daee9"
on_primary = "#0f0f0f"
secondary = "#1d99f3"
on_secondary = "#0f0f0f"
tertiary = "#9b59b6"
on_tertiary = "#0f0f0f"
error = "#da4453"
on_error = "#0f0f0f"
surface = "#141414"
on_surface = "#fcfcfc"
surface_variant = "#1e1e1e"
on_surface_variant = "#a1a9b1"
outline = "#707d8a"
shadow = "#1e1e1e"
hover = "#3daee9"
on_hover = "#0f0f0f"

[appearance.wallpaper]
path = "/usr/share/backgrounds/default-dark.png"
fill_mode = "crop"

[
EOF
fi
