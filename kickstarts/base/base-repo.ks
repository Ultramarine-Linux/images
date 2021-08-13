repo --name=fedora --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch
repo --name=updates --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f$releasever&arch=$basearch
#repo --name=updates-testing --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=updates-testing-f$releasever&arch=$basearch
url --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch
repo --name=ultramarine --baseurl=https://download.copr.fedorainfracloud.org/results/cappyishihara/ultramarine/fedora-$releasever-$basearch/
repo --name="fedora-cisco-openh264" --baseurl=https://codecs.fedoraproject.org/openh264/$releasever/$basearch/os/