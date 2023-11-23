#!/bin/bash -x
systemctl disable -f gdm.service
systemctl enable -f lightdm.service
# create /etc/sysconfig/desktop (needed for installation)

cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/gnome-session --builtin --session=pantheon
DISPLAYMANAGER=/usr/sbin/lightdm
EOF

sed -i 's/^livesys_session=.*/livesys_session="gnome"/' /etc/sysconfig/livesys
sed -i 's/Fedora/Ultramarine/g' /usr/share/anaconda/gnome/fedora-welcome
sed -i 's/Fedora/Ultramarine/g' /usr/share/applications/org.fedoraproject.welcome-screen.desktop
sed -i 's/Fedora/Ultramarine/g' /usr/share/anaconda/gnome/org.fedoraproject.welcome-screen.desktop


cat > /usr/share/glib-2.0/schemas/io.elementary.desktop.gschema.override << EOF
[net.launchpad.plank.dock.settings:Pantheon]
# TODO: insert apps missing from official Fedora repositories once available
# - appcenter
# - io.elementary.mail
# - io.elementary.tasks
dock-items=['gala-multitaskingview.dockitem','firefox.dockitem','io.elementary.calendar.dockitem','io.elementary.music.dockitem','io.elementary.videos.dockitem','io.elementary.photos.dockitem','io.elementary.switchboard.dockitem']
hide-delay=250
hide-mode='window-dodge'
show-dock-item=false
theme='Gtk+'

[org.freedesktop.ibus.general.hotkey:Pantheon]
triggers=['<Control>space']

[org.freedesktop.ibus.panel:Pantheon]
show=1

[org.gnome.desktop.background:Pantheon]
picture-options='zoom'
picture-uri='file:///usr/share/backgrounds/ultramarine-linux/39/foresty-skies-l.png'
primary-color='#000000'

[org.gnome.desktop.datetime:Pantheon]
automatic-timezone=true

[org.gnome.desktop.default-applications.terminal:Pantheon]
exec='io.elementary.terminal'

[org.gnome.desktop.input-sources:Pantheon]
xkb-options=['grp:alt_shift_toggle']

[org.gnome.desktop.interface:Pantheon]
cursor-theme='elementary'
document-font-name='Open Sans 10'
font-antialiasing='grayscale'
font-hinting='slight'
font-name='Inter 9'
gtk-theme='io.elementary.stylesheet.blueberry'
icon-theme='elementary'
# Roboto Mono is no longer available on Fedora, use Monospace instead
#monospace-font-name='Roboto Mono 10'
monospace-font-name='Monospace 10'

[org.gnome.desktop.peripherals.touchpad:Pantheon]
natural-scroll=true
tap-to-click=true

[org.gnome.desktop.privacy:Pantheon]
remove-old-temp-files=true
remove-old-trash-files=true

[org.gnome.desktop.session:Pantheon]
idle-delay=900

[org.gnome.desktop.sound:Pantheon]
theme-name='elementary'

[org.gnome.desktop.wm.keybindings:Pantheon]
# defaults to <Super>Up, replaced by toggle below, so we need to clear it here
maximize=[]
move-to-workspace-1=['<Super><Shift>1','<Super><Alt>1']
move-to-workspace-2=['<Super><Shift>2','<Super><Alt>2']
move-to-workspace-3=['<Super><Shift>3','<Super><Alt>3']
move-to-workspace-4=['<Super><Shift>4','<Super><Alt>4']
move-to-workspace-5=['<Super><Shift>5','<Super><Alt>5']
move-to-workspace-6=['<Super><Shift>6','<Super><Alt>6']
move-to-workspace-7=['<Super><Shift>7','<Super><Alt>7']
move-to-workspace-8=['<Super><Shift>8','<Super><Alt>8']
move-to-workspace-9=['<Super><Shift>9','<Super><Alt>9']
move-to-workspace-left=['<Super><Alt>Left']
move-to-workspace-right=['<Super><Alt>Right']
panel-main-menu=['<Super>space','<Alt>F2']
panel-run-dialog=[]
# Gala shows workspaces overview instead of desktop
show-desktop=['<Super>Down','<Super>s']
switch-applications=[]
switch-applications-backward=[]
# See lp:1291788 for details about switch-input-source*
switch-input-source=[]
switch-input-source-backward=[]
switch-to-workspace-left=['<Super>Left']
switch-to-workspace-right=['<Super>Right']
switch-to-workspace-up=[]
switch-to-workspace-down=[]
switch-to-workspace-1=['<Super>1']
switch-to-workspace-2=['<Super>2']
switch-to-workspace-3=['<Super>3']
switch-to-workspace-4=['<Super>4']
switch-to-workspace-5=['<Super>5']
switch-to-workspace-6=['<Super>6']
switch-to-workspace-7=['<Super>7']
switch-to-workspace-8=['<Super>8']
switch-to-workspace-9=['<Super>9']
switch-windows=['<Alt>Tab']
switch-windows-backward=['<Alt><Shift>Tab']
toggle-maximized=['<Super>Up']
# defaults to <Super>Down used above, so we need to override it
unmaximize=['<Alt>F5']

[org.gnome.desktop.wm.preferences:Pantheon]
# Make sure that all applications with CSD show their "Menu" button;
# otherwise, parts of the GUI of some GNOME applications is inaccessible.
#button-layout='close:maximize'
button-layout='close:menu,maximize'
mouse-button-modifier='<Super>'
resize-with-right-button=true
theme='elementary'

# Drop overrides for Epiphany - it's not the default browser on Fedora,
# and epiphany in Feodra does not have the elementary OS downstream patches.
#[org.gnome.Epiphany.ui:Pantheon]
#expand-tabs-bar=false
#tabs-bar-visibility-policy='always'
#
#[org.gnome.Epiphany.web:Pantheon]
#cookies-policy='no-third-party'
#enable-adblock=false
#enable-smooth-scrolling=true

[org.gnome.mutter:Pantheon]
auto-maximize=false
overlay-key='Super_L'
center-new-windows=true
workspaces-only-on-primary=true

[org.gnome.mutter.keybindings:Pantheon]
toggle-tiled-left=['<Control><Super>Left']
toggle-tiled-right=['<Control><Super>Right']

[org.gnome.nm-applet:Pantheon]
disable-connected-notifications=true
show-applet=false

[org.gnome.settings-daemon.peripherals.touchpad:Pantheon]
horiz-scroll-enabled=true
natural-scroll=true
scroll-method='two-finger-scrolling'

[org.gnome.settings-daemon.plugins.color:Pantheon]
night-light-temperature=4500

[org.gnome.settings-daemon.plugins.power:Pantheon]
idle-dim=false

[org.gnome.settings-daemon.plugins.xsettings:Pantheon]
overrides={'Gtk/DialogsUseHeader': <0>, 'Gtk/EnablePrimaryPaste': <0>, 'Gtk/ShellShowsAppMenu': <0>, 'Gtk/DecorationLayout': <'close:menu,maximize'>}

[org.gtk.Settings.FileChooser:Pantheon]
sort-directories-first=true

[org.onboard:Pantheon]
theme='/usr/share/onboard/themes/Nightshade.theme'

EOF

glib-compile-schemas /usr/share/glib-2.0/schemas/

cat >> /var/lib/livesys/livesys-session-extra << EOF

## set up lightdm autologin
sed -i 's/^#autologin-user=.*/autologin-user=liveuser/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user-timeout=.*/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf
#
# set Pantheon as default session, otherwise login will fail
sed -i 's/^#user-session=.*/user-session=pantheon/' /etc/lightdm/lightdm.conf

# set the default wallpaper
gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/ultramarine-linux/39/foresty-skies-l.png
mkdir -p /home/liveuser/.local/share/applications

# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/Desktop
cp /usr/share/applications/liveinst.desktop /home/liveuser/Desktop

# and mark it as executable
chmod +x /home/liveuser/Desktop/liveinst.desktop

# allow anaconda to use system icon theme
sed -i -e 's/settings.set_property("gtk-icon-theme-name", "Adwaita")//' /usr/lib64/python3.11/site-packages/pyanaconda/ui/gui/__init__.py

# this goes at the end after all other changes.
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

EOF

ELEMENTARY_APPS=(
    "io.elementary.calculator/$(uname -m)/stable"
    "io.elementary.calendar/$(uname -m)/stable"
    "io.elementary.capnet-assist/$(uname -m)/stable"
    "io.elementary.camera/$(uname -m)/stable"
    "io.elementary.mail/$(uname -m)/daily"
    "io.elementary.music/$(uname -m)/stable"
    "io.elementary.videos/$(uname -m)/stable"
    "org.gnome.Evince/$(uname -m)/stable"
)

arch=$(uname -m)
# Elementary's Flatpak remote only supports x86_64... even though it's 2023
if [[ $arch == "x86_64" ]]; then
# join them all together with a space
FLATPAKS=$(printf "%s " "${ELEMENTARY_APPS[@]}")

# install flatpaks

flatpak install -y appcenter $FLATPAKS
fi