#!/bin/bash
if [[ $(nmcli -t -f DEVICE,STATE dev | grep -P '^(wlan|wlp1s)[0-9]*:connected$') ]]; then 
    echo -e "%{F#00cc00}%{F-}"
else
    echo -e "%{F#ff0000}%{F-}"
fi
