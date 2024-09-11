#!/bin/bash

# Wifi
if [[ $(nmcli -t -f DEVICE,STATE dev | grep -P '^(wlan|wlp[0-9]s)[0-9]*:connected$') ]]; then 
    WIFI="%{F#00cc00}%{F-}"
else
    WIFI="%{F#ff0000}%{F-}"
fi

# Ethernet
if [[ $(nmcli -t -f DEVICE,STATE dev | grep -P '^(eth|enp[0-9]*s)([0-9]*f)?([0-9]*u)?[0-9]*:connected$') ]]; then 
    ETHERNET="%{F#00cc00}%{F-}"
else
    ETHERNET="%{F#ff0000}%{F-}"
fi

echo $WIFI $ETHERNET
