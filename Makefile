PRG = libdocklet-typebreaker.so
CC = gcc
VALAC = valac
PKGCONFIG = $(shell which pkg-config)
PACKAGES = gtk+-3.0 granite posix gdk-x11-3.0 plank
CFLAGS = `$(PKGCONFIG) --cflags $(PACKAGES)`
LIBS = `$(PKGCONFIG) --libs $(PACKAGES)`
VALAFLAGS = $(patsubst %, --pkg %, $(PACKAGES)) -X -fPIC -X -shared -X -D'GETTEXT_PACKAGE="typebreaker"' --library=$(PRG)

SOURCES = src/TypeBreakerDocklet.vala\
	src/TypeBreakerDockItem.vala\
	src/TypeBreaker.vala\
	src/Breaker.vala\
	src/BreakWindow.vala\
	src/ScreenLocker.vala\
	src/KeyGrabber.vala\
	src/TimeString.vala\
	src/Countdown.vala\
	src/CountdownClock.vala\
	src/get_idle_time.c

UIFILES =

#Disable implicit rules by empty target .SUFFIXES
.SUFFIXES:

.PHONY: all clean distclean

all: $(PRG)

$(PRG): $(SOURCES) $(UIFILES)
	glib-compile-resources typebreaker.gresource.xml --target=resources.c --generate-source
	$(VALAC) -o $(PRG) $(SOURCES) resources.c $(VALAFLAGS)

install:
	cp $(PRG) /usr/lib/x86_64-linux-gnu/plank/docklets/
	# killall plank



clean:
	# rm -f $(OBJS)
	rm -f $(PRG)

distclean: clean
	rm -f *.vala.c

