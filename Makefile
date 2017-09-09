PRG = com.github.hannenz.typebreaker-daemon
CC = gcc
VALAC = valac
PKGCONFIG = $(shell which pkg-config)
PACKAGES = gtk+-3.0 granite posix 
VALAFLAGS = $(patsubst %, --pkg %, $(PACKAGES)) -X -D'GETTEXT_PACKAGE="typebreaker"' 
SOURCES = src/Daemon/TypeBreakerDaemon.vala\
		src/Daemon/BreakManager.vala\
		src/Window/BreakWindow.vala\
		src/Settings.vala\
		src/Widgets/CountdownClock.vala\
		src/TimeString.vala\
		src/Countdown.vala


INDICATOR_PRG = libcom.github.hannenz.typebreaker-indicator.so
INDICATOR_PACKAGES = gtk+-3.0 granite wingpanel-2.0 
INDICATOR_VALAFLAGS = $(patsubst %, --pkg %, $(INDICATOR_PACKAGES)) -X -fPIC -X -shared --library=$(INDICATOR_PRG) -X -D'GETTEXT_PACKAGE="typebreaker"' 
INDICATOR_SOURCES = src/Indicator.vala\
	src/Settings.vala\
	src/TimeString.vala\
	src/SettingsDialog.vala\
	src/TimePeriodWidget.vala


#Disable implicit rules by empty target .SUFFIXES
.SUFFIXES:

.PHONY: all clean distclean

all: $(PRG)

$(PRG): $(SOURCES) typebreaker.gresource.xml
	glib-compile-resources typebreaker.gresource.xml --target=resources.c --generate-source
	$(VALAC) -o $(PRG) $(SOURCES) resources.c $(VALAFLAGS)



indicator: $(INDICATOR_SOURCES) typebreaker.gresource.xml $(PRG)
	glib-compile-resources typebreaker.gresource.xml --target=resources.c --generate-source
	$(VALAC) -o $(INDICATOR_PRG) $(INDICATOR_SOURCES) resources.c $(INDICATOR_VALAFLAGS)


install:
	# Binaries
	#install -o root -g root -m 644 $(PRG) /usr/local/bin/
	install -o root -g root -m 644 $(INDICATOR_PRG) /usr/lib/x86_64-linux-gnu/wingpanel/
	# GSettings Schema
	install -o root -g root -m 644 com.github.hannenz.typebreaker.gschema.xml /usr/share/glib-2.0/schemas/
	glib-compile-schemas /usr/share/glib-2.0/schemas
	# Desktop file, metadata and icon
	install -o root -g root -m 644 data/com.github.hannenz.typebreaker.desktop /usr/share/applications/
	install -o root -g root -m 644 data/com.github.hannenz.typebreaker.appdata.xml /usr/share/metainfo/
	install -o root -g root -m 644 data/typebreaker.svg /usr/share/icons/hicolor/16x16/apps/
	install -o root -g root -m 644 data/typebreaker.svg /usr/share/icons/hicolor/24x24/apps/
	install -o root -g root -m 644 data/typebreaker.svg /usr/share/icons/hicolor/32x32/apps/
	install -o root -g root -m 644 data/typebreaker.svg /usr/share/icons/hicolor/48x48/apps/
	install -o root -g root -m 644 data/typebreaker.svg /usr/share/icons/hicolor/64x64/apps/
	install -o root -g root -m 644 data/typebreaker.svg /usr/share/icons/hicolor/128x128/apps/
	install -o root -g root -m 644 data/typebreaker.svg /usr/share/icons/hicolor/scalable/apps/
	gtk-update-icon-cache /usr/share/icons/hicolor/
	# Autostart
	install -o root -g root -m 644 data/com.github.hannenz.typebreaker.desktop /etc/xdg/autostart/
	# Translations
	install -o root -g root -m 644 po/de_DE.mo /usr/share/locale/de/LC_MESSAGES/typebreaker.mo

uninstall:
	rm -f /usr/local/bin/$(PRG)
	rm -f /usr/lib/x86_64-linux-gnu/wingpanel/$(INDICATOR_PRG)
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
	rm -f /usr/share/locale/de/LC_MESSAGES/typebreaker.mo
	glib-compile-schemas /usr/share/glib-2.0/schemas
	gtk-update-icon-cache /usr/share/icons/hicolor/


pot:
	xgettext --language=C --keyword=_ --escape --sort-output -o po/com.github.hannenz.typebreaker.pot $(SOURCES) $(INDICATOR_SOURCES)

po:
	msgfmt --check --verbose -o po/de_DE.mo po/de_DE.po

clean:
	# rm -f $(OBJS)
	rm -f $(PRG)


distclean: clean
	rm -f *.vala.c

