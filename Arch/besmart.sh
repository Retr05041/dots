#!/bin/bash

echo "Ensuring all scripts are executable..."
chmod +x ./scripts/*.sh
chmod +x ./configs/config/scripts/*.sh

echo "Setting variables..."
WALLPAPER_PATH="/usr/share/wallpapers"
FONT_PATH="$HOME/.local/share/fonts"

clear
echo ""
echo "  =:| Automated Setup Script |:=    "
echo ""


base_sys_config () {
    echo "Setting custom fonts..."
    if [ ! -d $FONT_PATH ]; then mkdir -p $FONT_PATH; fi
    cp ./fonts/HackNerdFont-Regular.ttf $FONT_PATH
    fc-match "Hack Nerd Font"
    echo "Fonts set."
    echo "Setting .config dir..."
    cp -r ./configs/config/* ~/.config
    echo ".config set."
    echo "Setting dotfiles..."
    cp -a ./configs/dotfiles/. ~/
    echo "Dotfiles set."
    echo "Sourcing bash..."
    python ./scripts/sourcebash.py $HOME
    echo "Bash sourced."
    echo "Setting wallpaper..."
    set_wallpaper
    echo "Wallpaper set."
    main
}

post_configuration () {
    echo ""
    echo "1. Install Neovim"
    echo "2. Install Dropbox"
    echo "3. Setup Audio"
    echo "4. Replace ~/.mybshrc"
    echo "5. Replace custom .config/ files"
    echo "6. Replace custom .conf files" 
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
            cp ./configs/dotfiles/.mybashrc ~/
            post_configuration
            ;;
        "5")
            cp -r ./configs/config/* ~/.config
            post_configuration
            ;;
        "6")
            sudo cp -r ./configs/conf/* /etc/lightdm/
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
    echo "--- DIR CHECK '$WALLPAPER_PATH' ---"
    if [ -d $WALLPAPER_PATH ]; then rm $WALLPAPER_PATH/*; fi
    if ! [ -d $WALLPAPER_PATH ]; then mkdir $WALLPAPER_PATH; fi
    echo "--- MIGRATING IMAGES ---"
    sudo cp -a ../wallpapers/. $WALLPAPER_PATH
    echo "--- DONE ---"
}

main () {
    echo ""
    echo "1. Install needed packages & dependancies."
    echo "2. Base system config -- Fonts, .config, dotfiles, .mybashrc, wallpaper"
    echo "3. Post configuration"
    echo "9. Exit"
    read -p "Please enter your choice: " selection 

    case $selection in
        "1")
            ./scripts/base.sh
            ;;
        "2")
            base_sys_config
            ;;
        "3")
            post_configuration
            ;;
        "9")
            exit
            ;;
          *)
            echo "Invalid input."
            main
            ;;
    esac 
}
main

