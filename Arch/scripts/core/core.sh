#!/bin/bash

if ! [[ $(command -v yay) ]]; then
    echo "-- INSTALLING AUR --"
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf ./yay/
fi

echo "-- INSTALLING PACKAGES --"
pacman -S --needed --noconfirm base-devel wezterm dmenu i3-wm polybar lightdm xorg-server 
yay -S --noconfirm --needed lightdm-mini-greeter i3lock-color

# Sound + Transparency + battery
pacman -S --needed --noconfirm alsa-utils picom acpi spotify-launcher

# Bluetooth
pacman -S --needed --noconfirm bluez bluez-utils pulseaudio-bluetooth

# Wallpaper
pacman -S --needed --noconfirm feh

# Emoji support
pacman -S --needed --noconfirm noto-fonts-emoji noto-fonts-extra ttf-font-awesome
