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

base_yay_packages () {
    if [ ! command -v yay ]; then
        echo "yay not installed..."
        ./scripts/install_yay.sh
        echo "yay installed."
    fi

   ./scripts/install_dropbox.sh
   ./scripts/isntall_nvim.sh
   main
}

base_sys_config () {
    echo "Setting fonts..."
    if [ ! -d $HOME/.local/share/fonts]; then mkdir -p $HOME/.local/share/fonts fi
    cp ./fonts/HackNerdFont-Regular.ttf $HOME/.local/share/fonts
    fc-cache -fv
    fc-match "Hack Nerd Font"
    echo "Fonts set."
    echo "Setting configs..."
    cp -r ./configs/* ~/.config
    echo "Configs set."
    echo "Setting dotfiles..."
    cp -r ./dotfiles/* ~/
    echo "Dotfiles set."
    echo "Sourcing bash..."
    python ./scripts/sourcebash.py
    echo "Bash sourced."
    echo "Setting autostart files..."
    cp ./scripts/autostart_* /etc/X11/xinit/xinit.d/
    echo "Autostart files set."
    main
}

set_wallpaper () { 
    if [ ! -d /usr/share/wallpapers ]; then mkdir /usr/share/wallpapers fi
    cp -r ../wallpapers /usr/share
    cp ./scripts/autostart_wallpaper.sh /etc/X11/xinit/xinit.d/    
    ./scripts/autostart_wallpaper.sh
    main
}

main () {
    echo ""
    echo "1. Install base packages."
    echo "2. Base system config"
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
        set_wallpaper
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

