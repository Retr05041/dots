#!/bin/bash

BAT=$(acpi -b | grep -E -o '[0-9][0-9][0-9]?%')

# Full and short texts
echo "Battery: $BAT"
echo "BAT: $BAT"

# Set urgent flag below 5% or use orange below 20%
[ ${BAT%?} -le 14 ] && exit 33
[ ${BAT%?} -le 34 ] && echo "#FF8000"
[ ${BAT%?} -le 74 ] && echo "#e3e339"
[ ${BAT%?} -le 100 ] && echo "#11ff00"

exit 0
