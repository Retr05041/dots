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

set_wallpaper () { 
    echo "- MIGRATING IMAGES -"
    sudo cp -a ../wallpapers/. $(yq '.Base.wallpaperPath' settings.yml)
    echo "- SETTING NEW WALLPAPER VALUE -"
    python3 ./scripts/utils/confEditer.py ./configs/core/conf/lightdm-mini-greeter.conf background-image "\"/usr/share/wallpapers/$(yq '.Base.wallpaperName' settings.yml)\""
    python3 ./scripts/utils/alwaysExecEditer.py ./configs/core/config/i3/config "feh --bg-fill" /usr/share/wallpapers/$(yq '.Base.wallpaperName' settings.yml)
}

change_wallpaper () {
    echo $1
    exit
}

explicit_neovim () {
    echo $1
    exit
}

core () {
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

    yq -i '.Core.core=true' settings.yml 
    exit
}

optional () {
    echo -e "${YELLOW}--- INSTALLING OPTIONAL PACKAGES ---${ENDCOLOR}"
    sudo ./scripts/optional/optional.sh
    echo -e "${GREEN}--- DONE ---${ENDCOLOR}"
    echo -e "${YELLOW}--- LINKING OPTIONAL CONFIGS ---${ENDCOLOR}"

    # .config files/folders
    echo "-- .CONFIG LINKS --"
    cp -lfr ./configs/core/config/* $HOME/.config/
    echo -e "${GREEN}--- DONE ---${ENDCOLOR}"
        
    yq -i '.Optional.optional=true' settings.yml 
    exit
}

link () {
    if [[ $(yq '.Core.core' settings.yml) ]]; then
        echo -e "${YELLOW}--- LINKING CORE ---${ENDCOLOR}"
        echo -e "${GREEN}--- DONE ---${ENDCOLOR}"
    fi

    if [[ $(yq '.Optional.optional' settings.yml) ]]; then
        echo -e "${YELLOW}--- LINKING OPTIONAL ---${ENDCOLOR}"
        echo -e "${GREEN}--- DONE ---${ENDCOLOR}"
    fi
    
    exit
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

while getopts "hacolw:n:" opt; do
   case $opt in
    h)
        echo -e "

${BOLDGREEN}=:| Automated Setup Script |:=${ENDCOLOR}    
${ITALICGREY}Only one flag at at time.${ENDCOLOR}


${YELLOW}-h${ENDCOLOR} ~  Displays this help message

---

${YELLOW}-a${ENDCOLOR} ~  Sets up everything in one go: Core & Optional Depenancies, Programs, and Configs

${YELLOW}-c${ENDCOLOR} ~  Sets up core dependancies, programs, and configs

${YELLOW}-o${ENDCOLOR} ~  Sets up optional dependancies, programs, and configs

${YELLOW}-l${ENDCOLOR} ~  (Re)links all core and or optional configs

---

${YELLOW}-w {filename}${ENDCOLOR} ~ Set wallpaper to {filename} (be sure to include file extension)

${YELLOW}-n [install|link]${ENDCOLOR}  
    install: Install Neovim
    link:    (Re)link Neovim config
    ${ITALICGREY}If empty, both will run.${ENDCOLOR}
"
        exit
        ;;
    a)
        core
        optional
        ;;
    c)
        core
        ;;
    o)
        optional
        ;;
    l)
        link
        ;;
    w)
        change_wallpaper $OPTARG
        ;;
    n)
        explicit_neovim $OPTARG
        ;;
    :)
        echo "Flag $opt requires an argument"
        ;;
    \?)
        echo "Invalid flag ~ ./besmart [-h]"
        exit
        ;;
   esac 
done
