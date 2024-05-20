#!/bin/bash

echo "-- INSTALLING NVIM --"
pacman -S --needed node-lts-iron npm ripgrep
yay -S neovim-git
echo "-- DONE --"
