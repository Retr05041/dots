import sys

SOURCE = """if [ -f ~/.mybashrc ]; then
. ~/.mybashrc
fi
"""

with open(sys.argv[1] + "/.bashrc") as bashrc:
    if SOURCE in bashrc.read():
        print("Custom bashrc sourced already.")
        bashrc.close()
        exit()

with open(sys.argv[1] + "/.bashrc", "a") as bashrc:
    bashrc.write(SOURCE)
    bashrc.close()
    exit()
