# TypeBreaker

![Logo](https://github.com/hannenz/typebreaker/blob/master/data/typebreaker-pause.png)

A typing monitor and typing break application for elementary os inspired by drwright.

After i could not get drwright running on elementaryos I decided to port it and learn vala/ elementary development by this means.

## Dependencies (elementary loki / ubuntu 16.04)

```
# apt install libgranite-dev libwingpanel-2.0-dev
```

## Compile / Install

```
$ make
$ make indicator
$ sudo make install
```

## Configuration

TypeBreaker is configured via GSettings in path `com.github.hannenz.typebreaker.settings`
or via the settings dialog from the wingpanel indicator

### List available keys

```
$ gsettings list-keys com.github.hannenz.typebreaker.settings
```

At the moment these are:

- break-time: Duration of the break in seconds

- warn-time: When to notify before break - in seconds

- postpone-time: Time when postponing

- postpones-count: Allow n postpones

- active-time: Duration of non-idle time in seconds

e.g. set break time to 10 Minutes

```
$ gsettings set com.github.hannenz.typebreaker break-time 600
```

or use `dconf-editor`

