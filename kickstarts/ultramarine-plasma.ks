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
%post

# Inject a dummy .buildstamp so Anaconda doesn't complain
cat << EOF > /.buildstamp
[Main]
Product=Ultramarine
Version=36
BugURL=None
IsFinal=true
UUID=202112022224.x86_64
Variant=plasma
[Compose]
Lorax=35.7-1
EOF


#le cisco 
dnf config-manager --set-enabled fedora-cisco-openh264

%end

