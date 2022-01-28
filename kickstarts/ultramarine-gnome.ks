%include spins/gnome/gnome-base.ks

%packages

@base-x
@firefox
@libreoffice
@admin-tools
@core
@hardware-support
bash-completion
bind-utils
btrfs-progs
microcode_ctl
psmisc
@gnome-desktop

fuse
libreoffice

%end
%post
# Inject a dummy .buildstamp so Anaconda doesn't complain
cat << EOF > /.buildstamp
[Main]
Product=Ultramarine Linux
Version=35
BugURL=None
IsFinal=false
UUID=202112022224.x86_64
Variant=Basic
[Compose]
Lorax=35.7-1
EOF
%end