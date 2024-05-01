#!/bin/bash

echo "Ensuring all scripts are executable..."
chmod +x ./scripts/*.sh
chmod +x ./configs/config/scripts/*.sh

clear
echo ""
echo "  =:| Automated Setup Script |:=    "
echo ""

base () {
    echo "--- INSTALLING BASE PACKAGES ---"
    ./scripts/base.sh
    echo "--- DONE ---"
    if ! [ -d $HOME/.cargo ]; then
        echo "--- INSTALLING RUST ---"
        ./scripts/install_rust.sh
        echo "--- DONE ---"
    fi
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
    echo "3. Install Dropbox"
    echo "4. Setup Audio"
    echo "5. Replace ~/.mybshrc"
    echo "6. Replace custom .config/ files"
    echo "7. Replace custom .conf files" 
    echo "8. Replace custom wallpapers/ files"
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
            ./scripts/install_dropbox.sh
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
        "7")
            sudo cp -r ./configs/conf/* /etc/lightdm/
            ;;
        "8")
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
    echo "1. Install needed packages & dependancies."
    echo "2. Base system config -- Fonts, .config, dotfiles, .mybashrc, autostart scripts, wallpaper"
    echo "3. Post configuration"
    echo "9. Exit"
    read -p "Please enter your choice: " selection 

    case $selection in
        "1")
            base
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

