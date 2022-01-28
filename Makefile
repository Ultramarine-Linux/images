SPIN=budgie
RELEASEVER=36
DEVICE=/dev/null # the funny sentinel
BUILDDIR=$(shell echo $$PWD)/build
IMAGE=iso
PROJECT=Ultramarine Linux
LOCAL_REPO=true
ARCH=x86_64
LORAX=true

mock=mock -r mock/ultramarine-$(RELEASEVER)-$(shell uname -m).cfg --enable-network --rpmbuild-opts "--undefine _disable_source_fetch"
test:
	@echo $(BUILDDIR)


clean:
	@rm -rf build/*
#Image creation

kickstart:
	mkdir -p build/logs
	ksflatten --config kickstarts/ultramarine-$(SPIN).ks --output build/$(SPIN)-flattened.ks
image: clean kickstart
	@#echo "shutdown" >> $(BUILDDIR)/$(SPIN)-flattened.ks
	sudo rm -rf $(BUILDDIR)/image/
	livemedia-creator \
	--make-$(IMAGE) \
	--project "$(PROJECT)" \
	--releasever $(RELEASEVER) \
	--ks build/$(SPIN)-flattened.ks \
	--resultdir build/image \
	--logfile build/logs/livemedia-creator.log \
	--no-virt \
	--compression zstd \
	--iso-only \
	--iso-name Ultramarine-$(SPIN)-$(shell date +%y.%m).iso


liveimage: clean kickstart
	@#echo "shutdown" >> $(BUILDDIR)/$(SPIN)-flattened.ks
	sudo rm -rf $(BUILDDIR)/image/
	livemedia-creator \
	--make-$(IMAGE) \
	--project "$(PROJECT)" \
	--releasever $(RELEASEVER) \
	--ks build/budgie-flattened.ks \
	--resultdir build/liveimage \
	--logfile build/logs/livemedia-creator.log \
	--no-virt \
	--compression zstd

flagship: clean kickstart
	@#echo "shutdown" >> $(BUILDDIR)/$(SPIN)-flattened.ks
	sudo rm -rf $(BUILDDIR)/image/
	cd build-scripts; \
	livemedia-creator \
	--make-$(IMAGE) \
	--project "$(PROJECT)" \
	--releasever $(RELEASEVER) \
	--ks build/budgie-flattened.ks \
	--resultdir build/image \
	--logfile build/logs/livemedia-creator.log \
	--no-virt \
	--compression zstd \
	--iso-only \
	--iso-name Ultramarine-Flagship-$(shell date +%y.%m).iso

rebuild: clean pkg test kickstart image

docker: clean kickstart
	ksflatten -c kickstarts/ultramarine-docker.ks -o build/docker-flattened.ks
	sudo rm -rf $(BUILDDIR)/docker
	livemedia-creator \
	--make-tar \
	--no-virt \
	--ks build/docker-flattened.ks \
	--image-name ultramarine-docker.tar.xz \
	--resultdir build/docker

