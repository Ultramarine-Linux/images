#!/bin/sh
set -eu

# ultramarine-logos provides Anaconda's header, sidebar, and topbar artwork in
# /usr/share/anaconda. Update the remaining Fedora-facing welcome-screen text.
for file in \
    /usr/share/anaconda/gnome/fedora-welcome \
    /usr/share/applications/org.fedoraproject.welcome-screen.desktop \
    /usr/share/anaconda/gnome/org.fedoraproject.welcome-screen.desktop
do
    if [ -f "${file}" ]; then
        sed -i 's/Fedora/Ultramarine/g' "${file}"
    fi
done
