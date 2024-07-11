#!/bin/bash

source scripts/utils/bashlib.sh
colors

if ! [[ $(command -v yq) ]]; then
    read -p "YAML parser (yq) not found - install latest version of 'yq'? [y/n]: " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
        sudo pacman --needed --noconfirm -S go-yq       
    else
        echo "Ok, goodbye!"
        exit 1
    fi
fi

if ! [[ $(command -v yay) ]]; then
    read -p "AUR not found - install latest version? [y/n]: " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si
        cd ..
        rm -rf ./yay/
    else
        echo "Ok, goodbye!"
        exit 1
    fi
fi

# Make all scripts executable
find ./ -type f -iname "*.sh" -exec chmod +x {} \;

set_fonts () { 
    FONTPATH=$(yq '.Base.fontPath' settings.yml)
    echo "- SETTING CUSTOM FONT -"
    if [ -d $FONTPATH ]; then rm -r $FONTPATH; fi
    if [ ! -d $FONTPATH ]; then mkdir -p $FONTPATH; fi
    cp ./fonts/HackNerdFont-Regular.ttf $FONTPATH
    fc-match "Hack Nerd Font"
}

source_bash () {
    echo "- SOURCING BASH -"
    python ./scripts/utils/sourcebash.py $HOME
}

set_wallpaper () { 
    echo "- MIGRATING IMAGES -"
    sudo cp -a ./wallpapers/. $(yq '.Base.wallpaperPath' settings.yml)
    echo "- SETTING NEW WALLPAPER VALUE -"
    python3 ./scripts/utils/alwaysExecEditer.py ./configs/core/i3/config "feh --bg-fill" /usr/share/wallpapers/$(yq '.Base.wallpaperName' settings.yml)
}

change_wallpaper () {
    echo_color YELLOW "--- SETTINGS WALLPAPER ---"
    echo -n "Wallpaper exists: "
    if [ -f ./wallpapers/$1 ]; then echo_color GREEN ""; else echo_color RED ""; exit; fi
    yq -i ".Base.wallpaperName=\"$1\"" settings.yml
    set_wallpaper
    echo_color GREEN "--- DONE ---"
}

explicit_neovim () {
    case "$1" in
        all)
            echo_color GREEN $1
            ;;
        install)
            echo_color YELLOW $1
            ;;
        link)
            echo_color RED $1
            ;;
    esac
}

core () {
    echo_color YELLOW "--- INSTALLING CORE PACKAGES ---"
    sudo ./scripts/core/core.sh
    ./scripts/core/yay_core.sh
    ./scripts/core/setup_audio.sh
    sudo ./scripts/core/setup_bluetooth.sh
    echo_color GREEN "--- DONE ---"
    echo_color YELLOW "--- LINKING CORE CONFIGS ---"
    link_core
    set_fonts
    echo_color GREEN "--- DONE ---"
    echo_color YELLOW "--- SOURCING BASH ---"
    source_bash
    echo_color GREEN "--- DONE ---"
    echo_color YELLOW "--- SETTING WALLPAPER ---"
    set_wallpaper
    echo_color GREEN "--- DONE ---"

    yq -i '.Core.core=true' settings.yml 
}

link_core () {
    echo "-- LIGHTDM LINKS --"
    sudo cp -lf configs/special/lightdm.conf /etc/lightdm/
    sudo cp -lf configs/special/lightdm-mini-greeter.conf /etc/lightdm

    # .config files/folders
    echo "-- DOTFILE LINKS --"
    cp -lfr ./configs/core/* $HOME/.config/
    cp -lfr ./configs/core/.* $HOME/.config/
}

optional () {
    echo_color YELLOW "--- INSTALLING OPTIONAL PACKAGES ---"
    sudo ./scripts/optional/optional.sh
    ./scripts/optional/yay_optional.sh
    echo_color GREEN "--- DONE ---"
    echo_color YELLOW "--- LINKING OPTIONAL CONFIGS ---"

    link_optional
        
    yq -i '.Optional.optional=true' settings.yml 
}

link_optional () {
    echo "-- DOTEFILE LINKS --"
    cp -lfr ./configs/optional/* $HOME/.config/
}

link () {
    if [[ $(yq '.Core.core' settings.yml) ]]; then
        echo_color YELLOW "--- LINKING CORE ---"
        link_core
        echo_color GREEN "--- DONE ---"
    fi

    if [[ $(yq '.Optional.optional' settings.yml) ]]; then
        echo_color YELLOW "--- LINKING OPTIONAL ---"
        link_optional
        echo_color GREEN "--- DONE ---"
    fi
}

if [[ $# == 0 ]]; then
    $0 -h
fi

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h | --help)
            echo
            echo_color BOLDGREEN "=:| Automated Setup Script |:="
            echo_color ITALICGREY "Only one flag at at time."
            echo
            echo
            echo_color YELLOW "-h, --help"; 
            echo "  Displays this help message"
            echo
            echo "---"
            echo
            echo_color YELLOW "-a, --all"; 
            echo " Sets up everything in one go: Core & Optional Depenancies, Programs, and Configs"
            echo
            echo_color YELLOW "-c, --core"; 
            echo " Sets up core dependancies, programs, and configs"
            echo
            echo_color YELLOW "-o, --optional"; 
            echo " Sets up optional dependancies, programs, and configs"
            echo
            echo_color YELLOW "-l, --link"; 
            echo "  (Re)links all core and or optional configs"
            echo
            echo "---"
            echo
            echo_color YELLOW "-w, --wallpaper FILENAME"; 
            echo "  Set wallpaper to {filename} (be sure to include file extension)"
            echo
            echo_color YELLOW "-n, --neovim [all|install|link]"  
            echo "  all:     Install Neovim and (Re)link config."
            echo "  install: Install Neovim"
            echo "  link:    (Re)link config"

            shift 1
            ;;
        -a | --all)
            core
            optional
            shift 1
            ;;
        -c | --core)
            core
            shift 1
            ;;
        -o | --optional)
            optional
            shift 1
            ;;
        -l | --link)
            link
            shift 1
            ;;
        -w | --wallpaper)
            change_wallpaper "$2"
            shift 2
            ;;
        -n | --neovim)
            explicit_neovim "$2"
            shift 2
            ;;
        *)
            echo "Unknown flag: $1"
            echo "$(basename $0) [-h | --help]"
            exit
            ;;
    esac 
done
