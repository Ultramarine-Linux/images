%post
touch /etc/anaconda/product.d/ultramarine.conf
cat << EOF >>/etc/anaconda/product.d/ultramarine.conf
# Anaconda configuration file for Fedora Workstation Live.

[Anaconda]
activatable_modules =
    org.fedoraproject.Anaconda.Modules.Timezone
    org.fedoraproject.Anaconda.Modules.Network
    org.fedoraproject.Anaconda.Modules.Localization
    org.fedoraproject.Anaconda.Modules.Security
    org.fedoraproject.Anaconda.Modules.Users
    org.fedoraproject.Anaconda.Modules.Payloads
    org.fedoraproject.Anaconda.Modules.Storage
    org.fedoraproject.Anaconda.Modules.Services

[Product]
product_name = Ultramarine Linux

[Base Product]
product_name = Fedora

[Payload]
default_source = CLOSEST_MIRROR

default_rpm_gpg_keys =
    /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch

updates_repositories =
    updates
    updates-modular

[Bootloader]
menu_auto_hide = True

[User Interface]
custom_stylesheet = /usr/share/anaconda/pixmaps/ultramarine.css

EOF
%end