![typebreaker logo](https://github.com/hannenz/typebreaker/blob/master/data/typebreaker.svg)

# TypeBreaker

A typing monitor and typing break application for elementary os inspired by drwright.

After i could not get drwright running on elementaryos I decided to port it and learn vala/ elementary development by this means.

## Dependencies (Ubuntu)

```
# apt install elementary-sdk libx11-dev libxss-dev
```

## Compile / Install

```
$ mkdir build && cd build
$ cmake -DCMAKE_INSTALL_PREFIX=/usr ../
$ make
$ sudo make install
```

## Configuration

TypeBreaker is configured via GSettings in path `com.github.hannenz.typebreaker`

### List available keys

```
$ gsettings list-keys com.github.hannenz.typebreaker
```

At the moment these are:

- break-time: Duration of the break in seconds

- warn-time: When to notify before break - in seconds

- postpone-time: Time when postponing

- postpones: Allow n postpones

- type-time: Duration of non-idle time in seconds

e.g. set break time to 10 Minutes

```
$ gsettings set com.github.hannenz.typebreaker break-time 600
```

or use `dconf-editor`

