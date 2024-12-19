#!/bin/bash

colors() {
    # Define colors using ANSI escape codes
    RED='\033[0;31m'
    REDBACKGROUND='\033[0;41m'
    BOLDRED='\033[1;31m'
    GREEN='\033[0;32m'
    GREENBACKGROUND='\033[0;42m'
    BOLDGREEN='\033[1;32m'
    YELLOW='\033[0;33m'
    YELLOWBACKGROUND='\033[0;43m'
    BOLDYELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    BLUEBACKGROUND='\033[0;44m'
    BOLDBLUE='\033[1;34m'
    PURPLE='\033[0;35m'
    PURPLEBACKGROUND='\033[0;45m'
    BOLDPURPLE='\033[1;35m'
    CYAN='\033[0;36m'
    BOLDCYAN='\033[1;36m'

    ITALICGREY='\033[3;90m'
    NC='\033[0m' # No Color
}

echo_color() {
    local color="$1"
    local text="$2"
    echo -e "${!color}$text${NC}"
}
