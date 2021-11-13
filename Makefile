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


clean: build/
	@rm -rf build/*


#Image creation

kickstart:
	@cd build-scripts/
	ksflatten --config build-scripts/kickstarts/ultramarine-$(SPIN).ks --output $(BUILDDIR)/$(SPIN)-flattened.ks
endif

ifeq ($(LORAX),true)
image: kickstart
	@#echo "shutdown" >> $(BUILDDIR)/$(SPIN)-flattened.ks
	sudo rm -rf $(BUILDDIR)/image/
	cd build-scripts; \
	livemedia-creator \
	--make-$(IMAGE) \
	--project "$(PROJECT)" \
	--releasever $(RELEASEVER) \
	--ks $(BUILDDIR)/$(SPIN)-flattened.ks \
	--resultdir $(BUILDDIR)/image \
	--logfile $(BUILDDIR)/logs/livemedia-creator.log \
	--no-virt \
	--iso-only \
	--iso-name Ultramarine-$(SPIN)-$(RELEASEVER).iso

else
image: kickstart
	livecd-creator $(BUILDDIR)/$(SPIN)-flattened.ks\
	 -v\
	 --compression-type zstd\
	 -f UM-$(SPIN)\
	 --title "$(PROJECT)"\
	 --product "$(PROJECT)" --releasever=$(RELEASEVER)
	mv build-scripts/UM-$(SPIN) $(BUILDDIR)/image/
endif

rebuild: clean pkg test kickstart image
