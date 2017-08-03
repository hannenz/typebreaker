VALAC = valac
VALAFLAGS = -C
VALAPCKGS = --pkg gtk+-3.0 --pkg libnotify --pkg posix
CC = gcc
CFLAGS = -Wall
CPCKGS = `pkg-config --cflags --libs gtk+-3.0 libnotify x11 xscrnsaver`

VALASRCS = main.vala KeyGrabber.vala TypeBreaker.vala BreakWindow.vala
COBJS = $(VALASRCS:%.vala=%.c)
CSRCS = get_idle_time.c

all:	typebreaker

typebreaker: $(VALASRCS)
	$(VALAC) $(VALAFLAGS) $(VALAPCKGS) $(VALASRCS)
	$(CC) $(CFLAGS) -o $@ $(COBJS) $(CSRCS) $(CPCKGS)

.PHONY: clean
clean:
	rm -rf $(COBJS)
