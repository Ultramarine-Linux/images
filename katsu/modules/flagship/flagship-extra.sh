#!/bin/sh

# Extra setup for flagship

# We're gonna do a little hack here!


# Sadly, we can't replace the lightdm-gtk-greeter.conf file directly,
# but we want to theme it anyway, so we'll just copy the file to the correct location

# If any of the GTK greeter devs are reading this, please add a way to load drop-in files! :3
cp -v /etc/lightdm/lightdm.conf.d/50-ultramarine-lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf