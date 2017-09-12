PRG = com.github.hannenz.typebreaker-daemon
CC = gcc
VALAC = valac
PACKAGES = gtk+-3.0 granite posix 
VALAFLAGS = $(patsubst %, --pkg %, $(PACKAGES)) -X -D'GETTEXT_PACKAGE="typebreaker"' 
DATADIR=../../data
SOURCES = 	../Daemon/TypeBreakerDaemon.vala\
			../Daemon/BreakManager.vala\
			../Window/BreakWindow.vala\
			../Utils/Settings.vala\
			../Widgets/CountdownClock.vala\
			../Utils/TimeString.vala\
			../Utils/Countdown.vala

#Disable implicit rules by empty target .SUFFIXES
.SUFFIXES:

.PHONY: all clean distclean install uninstall

all: $(PRG)

$(PRG): $(SOURCES) resources.c
	$(VALAC) -o $@ $^ $(VALAFLAGS)

resources.c: $(DATADIR)/typebreaker-daemon.gresource.xml
	glib-compile-resources $< --sourcedir=$(DATADIR) --target=$@ --generate-source

install:
	-pkill -f $(PRG)
	# Binaries
	install -o root -g root -m 755 $(PRG) /usr/local/bin/
	# GSettings Schema
	install -o root -g root -m 644 $(DATADIR)/com.github.hannenz.typebreaker.gschema.xml /usr/share/glib-2.0/schemas/
	glib-compile-schemas /usr/share/glib-2.0/schemas
	# Desktop file, metadata and icon
	install -o root -g root -m 644 $(DATADIR)/com.github.hannenz.typebreaker.desktop /usr/share/applications/
	install -o root -g root -m 644 $(DATADIR)/com.github.hannenz.typebreaker.appdata.xml /usr/share/metainfo/
	install -o root -g root -m 644 $(DATADIR)/typebreaker.svg /usr/share/icons/hicolor/16x16/apps/
	install -o root -g root -m 644 $(DATADIR)/typebreaker.svg /usr/share/icons/hicolor/24x24/apps/
	install -o root -g root -m 644 $(DATADIR)/typebreaker.svg /usr/share/icons/hicolor/32x32/apps/
	install -o root -g root -m 644 $(DATADIR)/typebreaker.svg /usr/share/icons/hicolor/48x48/apps/
	install -o root -g root -m 644 $(DATADIR)/typebreaker.svg /usr/share/icons/hicolor/64x64/apps/
	install -o root -g root -m 644 $(DATADIR)/typebreaker.svg /usr/share/icons/hicolor/128x128/apps/
	install -o root -g root -m 644 $(DATADIR)/typebreaker.svg /usr/share/icons/hicolor/scalable/apps/
	install -o root -g root -m 644 $(DATADIR)/com.github.hannenz.typebreaker.service /usr/share/dbus-1/services
	gtk-update-icon-cache /usr/share/icons/hicolor/
	# Autostart
	install -o root -g root -m 644 $(DATADIR)/com.github.hannenz.typebreaker.desktop /etc/xdg/autostart/
	# Translations
	install -o root -g root -m 644 ../../po/de_DE.mo /usr/share/locale/de/LC_MESSAGES/typebreaker.mo

uninstall:
	rm -f /usr/local/bin/$(PRG)
	rm -f /usr/share/glib-2.0/schemas/com.github.hannenz.typebreaker.gschema.xml
	rm -f /usr/share/applications/com.github.hannenz.typebreaker.desktop 
	rm -f /usr/share/metainfo/com.github.hannenz.typebreaker.appdata.xml
	rm -f /usr/share/icons/hicolor/16x16/apps/typebreaker.svg
	rm -f /usr/share/icons/hicolor/24x24/apps/typebreaker.svg
	rm -f /usr/share/icons/hicolor/32x32/apps/typebreaker.svg
	rm -f /usr/share/icons/hicolor/48x48/apps/typebreaker.svg
	rm -f /usr/share/icons/hicolor/64x64/apps/typebreaker.svg
	rm -f /usr/share/icons/hicolor/128x128/apps/typebreaker.svg
	rm -f /usr/share/icons/hicolor/scalable/apps/typebreaker.svg
	rm -f /etc/xdg/autostart/com.github.hannenz.typebreaker.desktop
	rm -f /usr/share/dbus-1/services/com.github.hannenz.typebreaker.service
	rm -f /usr/share/locale/de/LC_MESSAGES/typebreaker.mo
	glib-compile-schemas /usr/share/glib-2.0/schemas
	gtk-update-icon-cache /usr/share/icons/hicolor/


pot:
	xgettext --language=C --keyword=_ --escape --sort-output -o ../../po/com.github.hannenz.typebreaker.pot $(SOURCES) $(INDICATOR_SOURCES)

po:
	msgfmt --check --verbose -o ../../po/de_DE.mo ../../po/de_DE.po

clean:
	# rm -f $(OBJS)
	rm -f $(PRG)


distclean: clean
	rm -f *.vala.c

