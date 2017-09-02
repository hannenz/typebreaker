PRG = typebreaker-daemon
INDICATOR_PRG = typebreaker-indicator
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

UIFILES =

#Disable implicit rules by empty target .SUFFIXES
.SUFFIXES:

.PHONY: all clean distclean

all: $(PRG)

$(PRG): $(SOURCES) $(UIFILES) typebreaker.gresource.xml
	glib-compile-resources typebreaker.gresource.xml --target=resources.c --generate-source
	$(VALAC) -o $(PRG) $(SOURCES) resources.c $(VALAFLAGS)


INDICATOR_SOURCES = src/Indicator.vala\
	src/Settings.vala\
	src/TimeString.vala\
	src/SettingsDialog.vala\
	src/TimePeriodWidget.vala


indicator: $(INDICATOR_SOURCES)
	valac -X -D'GETTEXT_PACKAGE="typebreaker"' -o typebreaker-indicator $^ --pkg gtk+-3.0 --pkg granite --pkg wingpanel-2.0 -X -fPIC -X -shared --library=typebreaker-indicator


install:
	# cp $(PRG) /usr/lib/x86_64-linux-gnu/plank/docklets/
	cp $(INDICATOR_PRG) /usr/lib/x86_64-linux-gnu/wingpanel/


schema:	com.github.hannenz.typebreaker.gschema.xml
	cp $< /usr/share/glib-2.0/schemas/
	glib-compile-schemas /usr/share/glib-2.0/schemas

clean:
	# rm -f $(OBJS)
	rm -f $(PRG)


distclean: clean
	rm -f *.vala.c

