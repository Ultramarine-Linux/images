# Minimal Disk Image

# Use network installation
%include ../base/base-repo.ks

# Root password
rootpw --plaintext ultramarine
# Network information
network  --bootproto=dhcp --activate
# System keyboard
keyboard --xlayouts=us --vckeymap=us
# System language
lang en_US.UTF-8
# SELinux configuration
selinux --enforcing
# Shutdown after installation
shutdown
# System timezone
timezone  US/Eastern
# System bootloader configuration
bootloader --disabled
# Partition clearing information
clearpart --all --initlabel
# Disk partitioning information
part / --fstype="ext4" --size=3000

%post
# Remove random-seed
rm /var/lib/systemd/random-seed
%end

%packages
@core
ultramarine-release
sudo
bash
coreutils
-fedora-release*
-kernel
%end