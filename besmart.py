# Automated Setup Script

import getpass
import subprocess
import os
import shutil

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
    
    # 'source ~/.bashrc' to autorefresh bash service

def main():
    print("")
    print("1. Source custom bash file.")
    print("9. Exit")
    choice = input("Please enter your choice: ")

    match choice:
        case "1":
            source_custom_bash()
        case "9":
            exit(0)
        case _:
            print("Invalid input.")
            main()

if __name__ == "__main__":
    main()