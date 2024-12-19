#!/bin/bash

echo "-- ENABLING BLUETOOTH --"
modprobe btusb

systemctl start bluetooth.service
systemctl enable bluetooth.service

# Rough Steps
# 
# bluetoothctl
# scan now (find device mac)
# pair {device mac}
# connect {device mac}
# trust {device mac}
#
# https://wiki.archlinux.org/title/Bluetooth
