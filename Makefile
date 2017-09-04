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



indicator: $(INDICATOR_SOURCES) typebreaker.gresource.xml
	glib-compile-resources typebreaker.gresource.xml --target=resources.c --generate-source
	$(VALAC) -o $(INDICATOR_PRG) $(INDICATOR_SOURCES) resources.c $(INDICATOR_VALAFLAGS)


install:
	#cp $(PRG) /usr/local/bin/
	cp $(INDICATOR_PRG) /usr/lib/x86_64-linux-gnu/wingpanel/
	cp com.github.hannenz.typebreaker.gschema.xml /usr/share/glib-2.0/schemas/
	glib-compile-schemas /usr/share/glib-2.0/schemas

pot:
	xgettext --language=C --keyword=_ --escape --sort-output -o po/com.github.hannenz.typebreaker.pot $(SOURCES) $(INDICATOR_SOURCES)

clean:
	# rm -f $(OBJS)
	rm -f $(PRG)


distclean: clean
	rm -f *.vala.c

