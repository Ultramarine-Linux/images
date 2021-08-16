%post
touch /usr/share/anaconda/interactive-defaults.ks
cat << EOF >>/usr/share/anaconda/interactive-defaults.ks
# Anaconda configuration file for Fedora Workstation Live.
firstboot --enable
EOF
%end