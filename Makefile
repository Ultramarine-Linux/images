SPIN=budgie
RELEASEVER=35
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
	cd build-scripts; \
	livemedia-creator \
	--make-$(IMAGE) \
	--project "$(PROJECT)" \
	--releasever $(RELEASEVER) \
	--ks build/$(SPIN)-flattened.ks \
	--resultdir build/image \
	--logfile build/logs/livemedia-creator.log \
	--no-virt \
	--compression zstd

rebuild: clean pkg test kickstart image
