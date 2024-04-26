#!/bin/bash

# sudo pacman -S alsa-utils
amixer sset Master unmute
amixer sset Speaker unmute
amixer sset Headphone unmute

echo "Run 'alsamixer' to set voume + mic audio"
