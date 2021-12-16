repo --name=fedora --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch --excludepkgs=neofetch
repo --name=updates --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f$releasever&arch=$basearch --excludepkgs=kernel*,neofetch
#repo --name=updates-testing --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=updates-testing-f$releasever&arch=$basearch
url --url=https://lapis.ultramarine-linux.org/pub/ultramarine/$releasever/Everything/$basearch/os/
#repo --name="fedora-cisco-openh264" --baseurl=https://codecs.fedoraproject.org/openh264/$releasever/$basearch/os/
#url --url=file:///home/cappy/Projects/uml-pungi/compose/latest-Ultramarine-35/compose/Everything/x86_64/os/