# Default postinstall kickstart config in Ultramarine
firstboot --enable
halt
%packages
initial-setup
initial-setup-gui
repo --name=ultramarine --baseurl=https://download.copr.fedorainfracloud.org/results/cappyishihara/ultramarine/fedora-$releasever-$basearch/
%end
%post
systemctl enable firstboot-text.service
systemctl enable firstboot-graphical.service
systemctl start firstboot-text.service
systemctl start firstboot-graphical.service
chkconfig livesys off
chkconfig livesys-late off 

%end
