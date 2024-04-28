#!/bin/bash

clear_screen () {
  clear
}

echo "Ensuring all scripts are executable..."
chmod +x ./scripts/*sh

clear_screen 
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
    echo "Setting configs..."
    cp -r ./configs/config/* ~/.config
    echo ".config set."
    echo "Setting dotfiles..."
    cp -a ./configs/dotfiles/. ~/
    echo "Dotfiles set."
    echo "Sourcing bash..."
    python ./scripts/sourcebash.py $HOME
    echo "Bash sourced."
    echo "Setting autostart files..."
    sudo cp ./scripts/autostart_* /etc/X11/xinit/xinitrc.d/
    echo "Autostart files set."
    echo "Setting wallpaper..."
    set_wallpaper
    echo "Wallpaper set."
    main
}

set_wallpaper () { 
    sudo cp -r ../wallpapers /usr/share
    ./scripts/autostart_wallpaper.sh
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

