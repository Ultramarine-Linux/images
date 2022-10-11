#base fedora stuff
%include spins/plasma/plasma-base.ks

%packages
#x server
@base-x

# install env-group to resolve RhBug:1891500
@^kde-desktop-environment

-scim*
-iok

%end


