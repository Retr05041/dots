#!/bin/bash

customBashSource="files/.mybashrc"

clear_screen () {
  clear
}

clear_screen 
echo ""
echo "  =:| Automated Setup Script |:=    "
echo ""

source_custom_bash () {
    if [ ! -f "$HOME/.mybashrc"]; then
        cp $customBashSource $HOME
        echo "Copied custom file to home directory."
    else 
        read -p "Replace '.mybashrc'? [y/n]: " replace
        if [ $replace == "y" ]; then
            cp $customBashSource $HOME
        fi
    fi
    python3 ./scripts/sourcebash.py "$HOME"
}

setup_go () {
    curl -LO https://go.dev/dl/go1.22.2.linux-amd64.tar.gz
    tar xvzf go1.22.2.linux-amd64.tar.gz
    sudo mv go /usr/local
    sudo ln -s /usr/local/go/bin/go /usr/local/bin
    sudo rm -rf go1.22.2.linux-amd64.tar.gz
    main
}

setup_guake () {
    sudo apt add-apt-repository ppa:linuxuprising/guake
    sudo apt update
    sudo apt install guake
    main
}

set_wallpaper () { 
    gsettings set org.gnome.desktop.background picture-uri file://./wallpapers/bladerunner.jpg
    main
}

main() {
    echo ""
    echo "1. Source custom bash file"
    echo "2. Install Golang"
    echo "3. Setup Guake"
    echo "4. Set wallpaper"
    echo "9. Exit"
    read -p "Please enter your choice: " selection 

    case $selection in
      "1")
        source_custom_bash
        ;;
      "2")
        setup_go
        ;;
      "3")
        setup_guake
        ;;
      "4")
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
