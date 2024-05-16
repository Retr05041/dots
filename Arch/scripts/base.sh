#!/bin/bash
# expected to have git installed and be in the user 'parker'

echo "--- INSTALLING AUR ---"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf ./yay/

echo "--- INSTALLING NEEDED PACKAGES ---"
pacman -S --needed base-devel wezterm dmenu i3-wm lightdm i3blocks xorg-server 
yay -S lightdm-mini-greeter i3lock-color

# Sound + Transparency + battery
pacman -S --needed alsa-utils picom acpi

# Bluetooth
pacman -S --needed bluez bluez-utils pulseaudio-bluetooth

# Wallpaper
pacman -S --needed feh

# Emoji support
pacman -S --needed noto-fonts-emoji noto-fonts-extra ttf-font-awesome

echo "--- INSTALLING OPTIONAL PACKAGES ---"
# Optional
pacman -S --needed firefox keepassxc zoxide discord
