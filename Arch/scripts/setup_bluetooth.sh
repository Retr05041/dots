#!/bin/bash

modprobe btusb

systemctl start bluetooth.service
systemctl enable bluetooth.service

# Might need to do some automated pairing...
# 
# bluetoothctl
# scan now (find device mac)
# pair {device mac}
# connect {device mac}
# trust {device mac}
#
# https://wiki.archlinux.org/title/Bluetooth
