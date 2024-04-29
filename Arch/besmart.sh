#!/bin/bash

echo "Ensuring all scripts are executable..."
chmod +x ./scripts/*.sh
chmod +x ./configs/config/scripts/*.sh

clear
echo ""
echo "  =:| Automated Setup Script |:=    "
echo ""

base_pac_packages () {
    ./scripts/base_pac_packages.sh
    main
}

base_sys_config () {
    echo "Setting fonts..."
    if [ ! -d $HOME/.local/share/fonts ]; then mkdir -p $HOME/.local/share/fonts; fi
    cp ./fonts/HackNerdFont-Regular.ttf $HOME/.local/share/fonts
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
    echo "1. Setup AUR"
    echo "2. Install Neovim"
    echo "3. Install Discord"
    echo "4. Setup Audio"
    echo "5. Replace ~/.mybshrc"
    echo "6. Replace custom .config files"
    echo "9. Exit"
    read -p "Please enter your choice: " selection 

    case $selection in
        "1")
            ./scripts/setup_yay.sh
            post_configuration
            ;;
        "2")
            ./scripts/install_neovim.sh
            post_configuration
            ;;
        "3")
            ./scripts/install_discord.sh
            post_configuration
            ;;
        "4")
            ./scripts/setup_audio.sh
            post_configuration
            ;;
        "5")
            cp ./configs/dotfiles/.mybashrc ~/
            post_configuration
            ;;
        "6")
            cp -r ./configs/config/* ~/.config
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
    sudo cp -r ../wallpapers /usr/share
}

main () {
    echo ""
    echo "1. Install base packages."
    echo "2. Base system config -- Fonts, .config, dotfiles, .mybashrc, autostart scripts, wallpaper"
    echo "3. Post configuration"
    echo "9. Exit"
    read -p "Please enter your choice: " selection 

    case $selection in
        "1")
            base_pac_packages
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

