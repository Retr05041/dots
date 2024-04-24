# Automated Setup Script

import getpass
import subprocess
import os
import shutil
from sys import executable
from time import sleep 

BASH_EXEC="/bin/bash"
CUSTOM_BASH_SOURCE = "files/.mybashrc"
HOME = "/home/parker/"

# Root checker
if (getpass.getuser() != "root"):
    print("Please run as root.")
    exit(1)

def clear_screen():
    subprocess.run("clear", shell=True, executable=BASH_EXEC)

clear_screen()
print("")
print("  =:| Automated Setup Script |:=    ")
print("")

def source_custom_bash():
    source = """if [ -f ~/.mybashrc ]; then
    . ~/.mybashrc
fi
"""
    
    if not os.path.exists(HOME + "/.mybashrc"):
        shutil.copy(CUSTOM_BASH_SOURCE, HOME)
        print("Copied custom file to home directory.")
    else:
        replace = input("Replace '.mybashrc'? [y/n]: ")
        if replace == "y":
            shutil.copy(CUSTOM_BASH_SOURCE, HOME)

    with open(HOME + "/.bashrc") as bashrc:
        if source in bashrc.read():
            print("Custom bashrc sourced already.")
            bashrc.close()
            main()
    with open(HOME + "/.bashrc", "a") as bashrc:
        bashrc.write(source)
        bashrc.close()
        main()

def setup_go():
    subprocess.run("curl -LO https://go.dev/dl/go1.22.2.linux-amd64.tar.gz", shell=True, executable=BASH_EXEC)
    sleep(10)
    subprocess.run("tar xvzf go1.22.2.linux-amd64.tar.gz", shell=True, executable=BASH_EXEC)
    subprocess.run("sudo mv go /usr/local", shell=True, executable=BASH_EXEC)
    subprocess.run("sudo ln -s /usr/local/go/bin/go /usr/local/bin", shell=True, executable=BASH_EXEC)
    subprocess.run("sudo rm -rf go1.22.2.linux-amd64.tar.gz", shell=True, executable=BASH_EXEC)
    main()

def setup_guake():
    subprocess.run("sudo apt add-apt-repository ppa:linuxuprising/guake", shell=True, executable=BASH_EXEC)
    subprocess.run("sudo apt update", shell=True, executable=BASH_EXEC)
    subprocess.run("sudo apt install guake", shell=True, executable=BASH_EXEC)
    main()

def set_wallpaper():
    subprocess.run("gsettings set org.gnome.desktop.background picture-uri file://./wallpapers/bladerunner.jpg", shell=True, executable=BASH_EXEC)
    main()

def main():
    print("")
    print("1. Source custom bash file")
    print("2. Install Golang")
    print("3. Setup Guake")
    print("4. Set wallpaper")
    print("9. Exit")
    choice = input("Please enter your choice: ")

    match choice:
        case "1":
            source_custom_bash()
        case "2":
            setup_go()
        case "3":
            setup_guake()
        case "4":
            set_wallpaper()
        case "9":
            exit(0)
        case _:
            print("Invalid input.")
            main()

if __name__ == "__main__":
    main()
