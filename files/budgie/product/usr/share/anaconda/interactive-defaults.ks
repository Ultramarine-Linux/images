# Default postinstall kickstart config in Ultramarine
firstboot --enable --reconfig
%packages
initial-setup
initial-setup-gui
%end
%post
touch /.unconfigured
systemctl enable firstboot-text.service
systemctl enable firstboot-graphical.service
systemctl start firstboot-text.service
systemctl start firstboot-graphical.service
systemctl start initial-setup.service
systemctl status initial-setup.service > /var/log/initsetup
chkconfig livesys off
chkconfig livesys-late off 
%end
