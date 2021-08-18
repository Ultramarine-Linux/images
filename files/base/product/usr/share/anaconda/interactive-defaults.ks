# Default postinstall kickstart config in Ultramarine
firstboot --enable --reconfig
%packages
initial-setup
initial-setup-gui
autostep
repo --name=ultramarine --baseurl=https://download.copr.fedorainfracloud.org/results/cappyishihara/ultramarine/fedora-$releasever-$basearch/
%end
%post
systemctl enable firstboot-text.service 2> /dev/null || :
systemctl enable firstboot-graphical.service 2> /dev/null || :
systemctl start firstboot-text.service 2> /dev/null || :
systemctl start firstboot-graphical.service 2> /dev/null || :
chkconfig livesys off
chkconfig livesys-late off 

%end
