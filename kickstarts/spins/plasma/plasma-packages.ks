
%packages
@firefox
@kde-apps
@kde-media
@libreoffice
# add libreoffice-draw and libreoffice-math (pagureio:fedora-kde/SIG#103)
libreoffice-draw
libreoffice-math

-@admin-tools

fuse

# Office
libreoffice-kf5

# use kde-print-manager instead of system-config-printer
-system-config-printer
# make sure mariadb lands instead of MySQL (hopefully a temporary hack)
mariadb-embedded
mariadb-connector-c
mariadb-server

# minimal localization support - allows installing the kde-l10n-* packages
kde-l10n

# unwanted packages from @kde-desktop
# don't include these for now to fit on a cd
-desktop-backgrounds-basic
-kdeaccessibility*
-ktorrent			# kget has also basic torrent features (~3 megs)
-digikam			# digikam has duplicate functionality with gwenview (~28 megs)
-kipi-plugins			# ~8 megs + drags in Marble
-krusader			# ~4 megs
-k3b				# ~15 megs

#-kdeplasma-addons		# ~16 megs

# Additional packages that are not default in kde-* groups, but useful
#kdeartwork			# only include some parts of kdeartwork
fuse
mediawriter

### space issues

# admin-tools
-gnome-disk-utility
# kcm_clock still lacks some features, so keep system-config-date around
#-system-config-date
# prefer kcm_systemd
-system-config-services
# prefer/use kusers
-system-config-users

-f*-backgrounds

procps-ng

-gnome-desktop*
xdg-desktop-portal-kde
-xdg-desktop-portal-gnome

xorg-x11-server-Xorg
ultramarine-release-identity-plasma
ultramarine-backgrounds-basic
kwin-system76-scheduler-integration

latte-dock

%end
