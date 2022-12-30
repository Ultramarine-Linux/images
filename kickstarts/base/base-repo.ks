url --url=https://repos.fyralabs.com/um$releasever/
repo --name=terra --baseurl=https://repos.fyralabs.com/terra$releasever/ --excludepkgs=dnf*
repo --name=fedora --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch
repo --name=updates --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f$releasever&arch=$basearch --excludepkgs=anaconda*
