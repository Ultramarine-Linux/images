# Default postinstall kickstart config in Ultramarine
firstboot --enable --reconfig
%packages
initial-setup
initial-setup-gui
%end
%post
systemctl enable firstboot-text.service 2> /dev/null || :
systemctl enable firstboot-graphical.service 2> /dev/null || :
systemctl start firstboot-text.service 2> /dev/null || :
systemctl start firstboot-graphical.service 2> /dev/null || :
touch /.autorelabel
%end