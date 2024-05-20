#!/bin/bash

if ! [[ $(command -v yq) ]]; then
    echo "yml parser not found - install latest version of yq?"
    read -p "TOML parser not found - install latest version of 'yq'? [y/n]: " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
        sudo pacman --needed --noconfirm -S go-yq       
    else
        echo "Ok, goodbye!"
        exit 1
    fi
fi

# Make all scripts executable
find ./ -type f -iname "*.sh" -exec chmod +x {} \;

# COLORS
RED="\e[31m"
BOLDRED="\e[1;31m"
GREEN="\e[32m"
BOLDGREEN="\e[1;32m"
YELLOW="\e[33m"
BOLDWHITE="\e[1;97m"
ITALICGREY="\e[3;90m"
ENDCOLOR="\e[0m"

set_fonts () { 
    echo "- SETTING CUSTOM FONT -"
    if [ ! -d $FONT_PATH ]; then mkdir -p $FONT_PATH; fi
    cp ./fonts/HackNerdFont-Regular.ttf $(yq '.Base.fontPath' settings.yml)
    fc-match "Hack Nerd Font"
}

source_bash () {
    echo "- SOURCING BASH -"
    python ./scripts/utils/sourcebash.py $HOME
}

post_configuration () {
    echo ""
    echo "1. Install Neovim"
    echo "2. Install Dropbox"
    echo "3. Setup Audio"
    echo "4. Setup Bluetooth"
    echo "7. Replace custom wallpapers/ files"
    echo "9. Exit"
    read -p "Please enter your choice: " selection 

    case $selection in
        "1")
            ./scripts/install_neovim.sh
            post_configuration
            ;;
        "2")
            ./scripts/install_dropbox.sh
            post_configuration
            ;;
        "3")
            ./scripts/setup_audio.sh
            post_configuration
            ;;
        "4")
            ./scripts/setup_bluetooth.sh
            post_configuration
            ;;
        "7")
            set_wallpaper
            post_configuration
            ;;
        "9")
            exit
            ;;
          *)
            echo "Invalid input."
            post_configuration
            ;;
    esac 
}

set_wallpaper () { 
    echo "- MIGRATING IMAGES -"
    sudo cp -a ../wallpapers/. $(yq '.Base.wallpaperPath' settings.yml)
    echo "- SETTING NEW WALLPAPER VALUE -"
    python3 ./scripts/utils/confEditer.py ./configs/core/conf/lightdm-mini-greeter.conf background-image "\"/usr/share/wallpapers/$(yq '.Base.wallpaperName' settings.yml)\""
    python3 ./scripts/utils/alwaysExecEditer.py ./configs/core/config/i3/config "feh --bg-fill" /usr/share/wallpapers/$(yq '.Base.wallpaperName' settings.yml)
}


# Flag must exist
if [[ $# == 0 ]]; then
    echo "./besmart [-h]"
    exit 1
fi

# Only 1 flag at a time
if [[ $# > 1 ]]; then
    echo "./besmart [-h]"
    exit 1
fi
if [[ ${#1} -ge 3 ]]; then
    echo "./besmart [-h]"
    exit 1
fi

while getopts "hac" opt; do
   case $opt in
    h)
        echo -e "

${BOLDGREEN}=:| Automated Setup Script |:=${ENDCOLOR}    


${YELLOW}-h${ENDCOLOR} ~  Displays this help message

${YELLOW}-a${ENDCOLOR} ~  Sets up everything in one go: Core & Optional Depenancies, Programs, and Configs

${YELLOW}-c${ENDCOLOR} ~  Sets up core dependancies, programs, and configs

${YELLOW}-o${ENDCOLOR} ~  Sets up optional dependancies, programs, and configs

${YELLOW}-l${ENDCOLOR} ~  (Re)links active configs

${ITALICGREY}Only one flag at at time.${ENDCOLOR}
"
        exit
        ;;
    a)
        echo -e "${YELLOW}--- INSTALLING CORE PACKAGES ---${ENDCOLOR}"
        sudo ./scripts/core/core.sh
        ./scripts/core/setup_audio.sh
        sudo ./scripts/core/setup_bluetooth.sh
        echo -e "${GREEN}--- DONE ---${ENDCOLOR}"
        echo -e "${YELLOW}--- LINKING CORE CONFIGS ---${ENDCOLOR}"
        echo "-- LIGHTDM LINKS --"
        sudo cp -lf configs/core/conf/lightdm.conf /etc/lightdm/
        sudo cp -lf configs/core/conf/lightdm-mini-greeter.conf /etc/lightdm

        # dotfiles
        echo "-- DOTFILE LINKS --"
        cp -lfr ./configs/core/dotfiles/.* $HOME

        # .config files/folders
        echo "-- .CONFIG LINKS --"
        cp -lfr ./configs/core/config/* $HOME/.config/
            
        # fontconfig
        echo "-- FONTCONFIG LINK --"
        set_fonts
        cp -lfr ./configs/core/fontconfig $HOME

        echo -e "${GREEN}--- DONE ---${ENDCOLOR}"
        echo -e "${YELLOW}--- SOURCING BASH ---${ENDCOLOR}"
        source_bash
        echo -e "${GREEN}--- DONE ---${ENDCOLOR}"
        echo -e "${YELLOW}--- SETTING WALLPAPER ---${ENDCOLOR}"
        set_wallpaper
        echo -e "${GREEN}--- DONE ---${ENDCOLOR}"
        exit
        ;;
    \?)
        echo "./besmart [-h]"
        exit
        ;;
   esac 
done
