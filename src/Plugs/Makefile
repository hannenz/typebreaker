
all:
	valac --thread -o TypeBreaker main.vala --pkg gtk+-3.0 --pkg switchboard-2.0

install:
	mkdir -p /usr/lib/plugs/TypeBreaker
	cp TypeBreaker /usr/lib/plugs/TypeBreaker/
	cp typebreaker.plug /usr/lib/plugs/TypeBreaker/
	cp org.pantheon.typebreaker.gschema.xml /usr/share/glib-2.0/schemas/
	glib-compile-schemas /usr/share/glib-2.0/schemas/ 

clean:
	rm *.c

