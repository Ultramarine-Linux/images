url --url=https://subatomic.fyralabs.com/um$releasever/
repo --name=terra --baseurl=https://subatomic.fyralabs.com/ad$releasever/
repo --name=fedora --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch --excludepkgs=neofetch
repo --name=updates --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f$releasever&arch=$basearch --excludepkgs=kernel*,neofetch
