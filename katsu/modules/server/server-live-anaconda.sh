#!/bin/bash -x
# Set up the Server Anaconda installer image: a minimal live system that
# boots straight into the text-mode Anaconda installer on the console,
# instead of a desktop session.

# No display manager on this image, boot to a text console
systemctl set-default multi-user.target

# Run the installer inside a tmux session, mirroring the units Anaconda
# itself uses on the classic boot.iso (anaconda.service + anaconda-tmux@.service),
# but starting the live image installer in text mode instead.
# This also provides a shell and log windows, switchable with Alt+Tab.
sed 's|^new-session -d -s anaconda -n main anaconda$|new-session -d -s anaconda -n main "anaconda --liveinst --text"|' \
    /usr/share/anaconda/tmux.conf > /usr/share/anaconda/tmux-live.conf

# Backend service: starts the tmux session with the installer running
cat > /usr/lib/systemd/system/ultramarine-anaconda.service << 'EOF'
[Unit]
Description=Ultramarine Linux Installer
# Only run inside the live installer environment, never on an installed system
ConditionKernelCommandLine=rd.live.image
Wants=NetworkManager.service systemd-udev-settle.service
After=NetworkManager.service systemd-udev-settle.service

[Service]
Type=forking
Environment=HOME=/root LANG=en_US.UTF-8 PATH=/usr/bin:/bin:/sbin:/usr/sbin XDG_RUNTIME_DIR=/run/user/0
WorkingDirectory=/root
ExecStart=/usr/bin/tmux -u -f /usr/share/anaconda/tmux-live.conf start

[Install]
WantedBy=multi-user.target
EOF

# Console service: attaches tty1 to the installer tmux session
cat > /usr/lib/systemd/system/ultramarine-anaconda-tty@.service << 'EOF'
[Unit]
Description=Ultramarine Linux Installer console on %I
Requires=ultramarine-anaconda.service
After=ultramarine-anaconda.service
# Only run inside the live installer environment, never on an installed system
ConditionKernelCommandLine=rd.live.image
Conflicts=getty@%i.service
After=getty@%i.service

[Service]
Type=idle
Environment=HOME=/root LANG=en_US.UTF-8 TERM=linux
WorkingDirectory=/root
ExecStart=/usr/bin/tmux -u attach -t anaconda
StandardInput=tty
StandardOutput=tty
TTYPath=/dev/%I
TTYReset=yes
TTYVHangup=yes
TTYVTDisallocate=yes
Restart=always
RestartSec=1

[Install]
WantedBy=multi-user.target
EOF

systemctl enable ultramarine-anaconda.service
systemctl enable ultramarine-anaconda-tty@tty1.service

# Locale defaults, same as the other live images
cat > /etc/locale.conf << EOF
LANG=en_US.UTF-8
LANGUAGE=en_US.UTF-8
LC_ALL=en_US.UTF-8
EOF
