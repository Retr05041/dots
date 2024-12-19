import sys


SOURCE_OPTIONAL = """if [ -f ~/.config/.myoptionalbashrc ]; then
    . ~/.config/.myoptionalbashrc
fi
"""

with open(sys.argv[1] + "/.bashrc") as bashrc:
    if SOURCE_OPTIONAL in bashrc.read():
        print("Custom bashrc sourced already.")
        bashrc.close()
        exit()

with open(sys.argv[1] + "/.bashrc", "a") as bashrc:
    bashrc.write(SOURCE_OPTIONAL)
    bashrc.close()
    exit()
