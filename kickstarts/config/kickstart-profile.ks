%include profile-anaconda.ks
##Anaconda fix
%post
touch /etc/anaconda/product.d/ultramarine.conf
cat << EOF >>/etc/anaconda/product.d/ultramarine.conf
# Anaconda configuration file for Fedora Workstation Live.


[Product]
product_name = Ultramarine Linux
product_id = ultramarine
[Base Product]
product_name = Fedora
variant_name =  Workstation
[Payload]
default_source = CLOSEST_MIRROR

default_rpm_gpg_keys =
    /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch

updates_repositories =
    updates
    updates-modular

[Bootloader]
menu_auto_hide = False

[User Interface]
custom_stylesheet = /usr/share/anaconda/pixmaps/ultramarine.css
[Profile Detection]
# Match os-release values.
os_id = ultramarine
EOF
%end