%include ../../base/base.ks
%include budgie-packages.ks

services --disabled=gdm
%post

# set livesys session type
sed -i 's/^livesys_session=.*/livesys_session="budgie"/' /etc/sysconfig/livesys

%end
