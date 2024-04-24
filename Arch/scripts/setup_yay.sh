#!/bin/bash
echo "Installing latest version of Go and yay"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf ./yay/
