PRG = com.github.hannenz.typebreaker-indicator
CC = gcc
VALAC = valac
PACKAGES = gtk+-3.0 granite wingpanel-2.0 
VALAFLAGS = $(patsubst %, --pkg %, $(PACKAGES)) -X -fPIC -X -shared --library=$(PRG) -X -D'GETTEXT_PACKAGE="typebreaker"' 
DATADIR=../../data
SOURCES = ../Indicator/Indicator.vala\
	../Utils/Settings.vala\
	../Utils/TimeString.vala\
	../Widgets/SettingsDialog.vala\
	../Widgets/TimePeriodWidget.vala



#Disable implicit rules by empty target .SUFFIXES
.SUFFIXES:

.PHONY: all clean distclean

all: $(PRG)

$(PRG): $(SOURCES) resources.c
	$(VALAC) -o $@ $^ $(VALAFLAGS)

resources.c: $(DATADIR)/typebreaker-indicator.gresource.xml
	glib-compile-resources $< --sourcedir=$(DATADIR) --target=$@ --generate-source

install:
	install -o root -g root -m 644 $(PRG) /usr/lib/x86_64-linux-gnu/wingpanel/
	# Todo: Use own translations for indicator
	install -o root -g root -m 644 ../../po/de_DE.mo /usr/share/locale/de/LC_MESSAGES/typebreaker.mo

uninstall:
	rm -f /usr/lib/x86_64-linux-gnu/wingpanel/$(PRG)

clean:
	# rm -f $(OBJS)
	rm -f $(PRG)


distclean: clean
	rm -f resources.c
	rm -f *.vala.c

