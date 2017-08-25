PRG = libdocklet-typebreaker.so
CC = gcc
VALAC = valac
PKGCONFIG = $(shell which pkg-config)
PACKAGES = gtk+-3.0 granite posix gdk-x11-3.0 plank x11 
# CFLAGS = `$(PKGCONFIG) --cflags $(PACKAGES) x11 xscrnsaver`
# LIBS = `$(PKGCONFIG) --libs $(PACKAGES) x11 xscrnsaver`
# VALAFLAGS = $(patsubst %, --pkg %, $(PACKAGES)) -X -fPIC -X -shared -X -D'GETTEXT_PACKAGE="typebreaker"' -X -LXss -X -LX11 --library=$(PRG)
VALAFLAGS = $(patsubst %, --pkg %, $(PACKAGES)) -X -D'GETTEXT_PACKAGE="typebreaker"' -C
CFLAGS = -fPIC -shared --library=$(PRG) -LXss -LX11

SOURCES = src/TypeBreakerDocklet.vala\
	src/TypeBreakerDockItem.vala\
	src/TypeBreakerPreferences.vala\
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
	# Compile vala to C
	$(VALAC) -C $(SOURCES) $(VALAFLAGS)
	# Compile .c to .o
	$(CC) -o $(PRG) -shared -fPIC src/*.c
	
	$(CC) -shared -o $(PRG) *.o -lc 

	#$(VALAC) -o $(PRG) $(SOURCES) resources.c $(VALAFLAGS)

install:
	cp $(PRG) /usr/lib/x86_64-linux-gnu/plank/docklets/
	killall plank



clean:
	# rm -f $(OBJS)
	rm -f $(PRG)

distclean: clean
	rm -f *.vala.c

