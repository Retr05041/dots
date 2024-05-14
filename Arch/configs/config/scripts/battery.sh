#!/bin/bash

BAT=$(acpi -b | grep -E -o '[0-9][0-9][0-9]?%')

# Full and short texts
echo "Battery: $BAT"
echo "BAT: $BAT"

# Set urgent flag below 5% or use orange below 20%
[ ${BAT%?} -ge 75 ] && echo "#11ff00"
[ ${BAT%?} -ge 50 ] && [ ${BAT%?} -lt 74 ] && echo "#e3e339"
[ ${BAT%?} -ge 25 ] && [ ${BAT%?} -le 49 ] && echo "#FF8000"
[ ${BAT%?} -le 24 ] && echo "#a80c0e"

exit 0
