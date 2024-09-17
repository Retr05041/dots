#!/bin/bash

echo "-- INSTALLING PACKAGES --"
pacman -S --needed --noconfirm base-devel wezterm dmenu i3-wm polybar lightdm lightdm-slick-greeter xclip xorg-xrandr ntfs-3g

# Sound + Transparency + battery
pacman -S --needed --noconfirm alsa-utils picom acpi spotify-launcher pavucontrol

# Bluetooth
pacman -S --needed --noconfirm bluez bluez-utils 

# Wallpaper
pacman -S --needed --noconfirm feh

# Emoji support
pacman -S --needed --noconfirm noto-fonts-emoji noto-fonts-extra ttf-font-awesome

# Utils
pacman -S --needed openssh
