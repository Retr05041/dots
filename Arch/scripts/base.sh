#!/bin/bash

# Needed
pacman -S --needed base-devel wezterm dmenu i3-wm lightdm lightdm-slick-greeter i3blocks xorg-server 

# Sound + Transparency + battery
pacman -S --needed alsa-utils picom acpi

# Wallpaper
pacman -S --needed feh

# Emoji support
pacman -S --needed noto-fonts-emoji noto-fonts-extra

# Optional
pacman -S --needed firefox keepassxc zoxide discord
