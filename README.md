#TypeBreaker

A typing monitor and typing break application inspired by drwright.
After i could not get drwright running on elementaryos I decided
to port it and learn vala/ elementary development by this means.

The result is a bit of a clone/ rewrite/ hack which gets its job
done and helped me diving into vala programming.

# Dependencies (Ubuntu)

```
# apt install elementary-sdk libx11-dev libxss-dev

## Compile / Install

```
$ mkdir build && cd build
$ cmake -DCMAKE_INSTALL_PREFIX=/usr ../
$ make
$ sudo make install
```

## Configuration

Typebraker is configured via GSettings in path `/com/github/hannenz/typebreaker`, so use dconf-editor or `dconf-`

### List available keys

```
$ gsettings list-keys com.github.hannenz.typebreaker
```

At the moment these are:

break-time: Duration of the break in seconds

warn-time: When to notify before break - in seconds

postpone-time: Time when postponing

postpones: Allow n postpones

type-time: Duration of non-idle time in seconds

e.g. set break time to 10 Minutes

```
$ gsettings set com.github.hannenz.typebreaker break-time 600
```

or use `dconf-editor`

