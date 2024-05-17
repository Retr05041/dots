#!/bin/bash

readarray -t CONNECTED_DEVICES < <(bluetoothctl devices Connected | grep -Po '(?<=\b(?:[0-9A-Fa-f]{2}[:-]){5}[0-9A-Fa-f]{2}\b\s).*$')

if [[ ${CONNECTED_DEVICES[@]} =~ "Keychron K2 Pro" ]]; then
    KEYBOARD=""
else
    KEYBOARD=""
fi

if [[ ${CONNECTED_DEVICES[@]} =~ "MX Master 3S" ]]; then
    MOUSE="🖱️"
else
    MOUSE=""
fi

echo $KEYBOARD $MOUSE

