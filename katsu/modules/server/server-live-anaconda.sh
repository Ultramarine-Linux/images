#!/bin/bash -x
# Start Fedora's Anaconda WebUI in a minimal GNOME live session.

systemctl set-default graphical.target
systemctl enable livesys.service
systemctl enable livesys-late.service
systemctl enable gdm.service

# Provide a real GNOME Session/GDM kiosk session. Autostarting gnome-kiosk
# inside the normal GNOME session leaves GNOME Shell running, so it cannot
# produce a kiosk-only desktop.
cat > /usr/local/bin/ultramarine-server-installer << 'EOF'
#!/bin/sh
# Keep a launch failure available from the serial/login console for diagnosis.
exec /usr/bin/liveinst >>/var/log/ultramarine-server-installer.log 2>&1
EOF
chmod 0755 /usr/local/bin/ultramarine-server-installer

cat > /usr/share/applications/ultramarine-server-installer.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=Install Ultramarine Linux
Comment=Start the Ultramarine Linux installer
Exec=/usr/local/bin/ultramarine-server-installer
Terminal=false
X-GNOME-Autostart-Phase=Application
X-GNOME-AutoRestart=true
EOF

# GNOME Session on Fedora 44 starts session components through systemd user
# units. A legacy RequiredComponents session file alone creates an empty
# session, so make the kiosk compositor and installer explicit dependencies.
mkdir -p /usr/lib/systemd/user/gnome-session@ultramarine-server-installer.target.d
cat > /usr/lib/systemd/user/gnome-session@ultramarine-server-installer.target.d/session.conf << 'EOF'
[Unit]
Requires=gnome-session-services.target
Requires=org.gnome.Kiosk.target
Requires=ultramarine-server-installer.service
EOF

cat > /usr/lib/systemd/user/ultramarine-server-installer.service << 'EOF'
[Unit]
Description=Ultramarine Server Anaconda WebUI
PartOf=graphical-session.target
After=org.gnome.Kiosk@wayland.service

[Service]
ExecStart=/usr/local/bin/ultramarine-server-installer
Restart=on-failure
RestartSec=2
EOF

cat > /usr/share/gnome-session/sessions/ultramarine-server-installer.session << 'EOF'
[GNOME Session]
Name=Ultramarine Server Installer
EOF

cat > /usr/share/wayland-sessions/ultramarine-server-installer.desktop << 'EOF'
[Desktop Entry]
Name=Ultramarine Server Installer
Comment=Ultramarine Server installation environment
Exec=gnome-session --session=ultramarine-server-installer
Type=Application
DesktopNames=GNOME
EOF

# livesys creates liveuser during boot. GDM reads its selected Wayland session
# from AccountsService, so pre-create the record before automatic login.
mkdir -p /var/lib/AccountsService/users
cat > /var/lib/AccountsService/users/liveuser << 'EOF'
[User]
Session=ultramarine-server-installer
XSession=ultramarine-server-installer
EOF

sed -i 's/^livesys_session=.*/livesys_session="gnome"/' /etc/sysconfig/livesys

cat > /etc/locale.conf << 'EOF'
LANG=en_US.UTF-8
LANGUAGE=en_US.UTF-8
LC_ALL=en_US.UTF-8
EOF
