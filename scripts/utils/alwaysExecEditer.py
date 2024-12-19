import argparse
import os

parser = argparse.ArgumentParser(description="Change any pre-existing 'exec_always' in a file")

parser.add_argument("autoPath", help="Path to file that holds the autoruns", type=str)
parser.add_argument("command", help="Command to edit", type=str)
parser.add_argument("arguments", help="Arugments for command", type=str)
args = parser.parse_args()

def main(): 
    if not os.path.lexists(args.autoPath):
        print("Invalid path:", args.autoPath)
        return

    autoLines = []
    with open(args.autoPath, "r") as autoFile:
        autoLines = autoFile.readlines()

    lineIndex = 0
    with open(args.autoPath, "r") as autoFile:
        for index, line in enumerate(autoFile):
            if "exec_always " + args.command in line:
                lineIndex = index
                break
            
    autoLines[lineIndex] = "exec_always " + args.command + " " + args.arguments + "\n"

    with open(args.autoPath, "w") as autoFile:
        autoFile.writelines(autoLines)

    return

if __name__ == "__main__":
    main()
