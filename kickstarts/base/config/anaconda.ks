#Custom Anaconda Configuration

%post
# show logs please
#chvt # don't
#exec < /dev/tty3 > /dev/tty3 2>/dev/tty3

echo "Adding Anaconda configuration..."

#heredoc
cat << EOF >> /usr/share/anaconda/interactive-defaults.ks
repo --name=fedora --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch --excludepkgs=neofetch
repo --name=updates --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f$releasever&arch=$basearch --excludepkgs=kernel*,neofetch
url --url=https://lapis.ultramarine-linux.org/pub/ultramarine/$releasever/Everything/$basearch/os/
EOF

%end