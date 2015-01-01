NAME=kbatsysfs
VERSION=1.0.0
OUT=$(NAME)-$(VERSION).plasmoid

TAR=tar
ZIP=zip
PLASMOIDVIEWER=plasmoidviewer
PLASMAPKG=plasmapkg
PLASMAPKG_FLAGS=

GENERATED_FILES = \
	metadata.desktop \
	$(NULL)

NON_RUNTIME_FILES = \
	Makefile \
	metadata.desktop.in \
	$(NULL)

FILES = \
	AUTHORS \
	COPYING \
	ChangeLog \
	README.md \
	contents/code/main.js \
	contents/config/main.xml \
	contents/images/0%.png \
	contents/images/100%.png \
	contents/images/20%.png \
	contents/images/40%.png \
	contents/images/60%.png \
	contents/images/80%.png \
	contents/images/power.png \
	contents/qml/main.qml \
	contents/ui/config.ui \
	icon.png \
	$(NULL)

.SUFFIXES: .in

.in:
	sed \
		-e 's/@NAME@/$(NAME)/g' \
		-e 's/@VERSION@/$(VERSION)/g' \
		'$<' > '$@'

all:	$(GENERATED_FILES)
	rm -f '$(OUT)'
	$(ZIP) '$(OUT)' $(FILES) $(GENERATED_FILES)

clean:
	rm -f metadata.desktop
	rm -f '$(OUT)'

dist:
	$(TAR) -czf '$(NAME)-$(VERSION).tar.gz' --xform 's#^#$(NAME)-$(VERSION)/#' \
		$(NON_RUNTIME_FILES) $(FILES)

test:	all
	$(PLASMOIDVIEWER) .

uninstall:
	-$(PLASMAPKG) $(PLASMAPKG_FLAGS) -r '$(NAME)'
	sleep 2

install:	all uninstall
	$(PLASMAPKG) $(PLASMAPKG_FLAGS) -i '$(OUT)'
