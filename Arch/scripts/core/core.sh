#!/bin/bash

echo "-- INSTALLING PACKAGES --"
pacman -S --needed --noconfirm base-devel wezterm dmenu i3-wm polybar lightdm lightdm-slick-greeter

# Sound + Transparency + battery
pacman -S --needed --noconfirm alsa-utils picom acpi spotify-launcher

# Bluetooth
pacman -S --needed --noconfirm bluez bluez-utils pulseaudio-bluetooth

# Wallpaper
pacman -S --needed --noconfirm feh

# Emoji support
pacman -S --needed --noconfirm noto-fonts-emoji noto-fonts-extra ttf-font-awesome
