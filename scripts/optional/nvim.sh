#!/bin/bash

echo "-- INSTALLING NVIM --"
pacman -S --needed nodejs-lts-iron npm ripgrep
yay -S neovim-git
echo "-- DONE --"
