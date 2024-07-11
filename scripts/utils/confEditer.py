import argparse
import os

parser = argparse.ArgumentParser(description="Edit a pre-existing '.conf' file")

parser.add_argument("confPath", help="Path to conf file", type=str)
parser.add_argument("attribute", help="Specific attribute to edit", type=str)
parser.add_argument("value", help="value to set for the attribute", type=str)
args = parser.parse_args()

def main(): 
    if not os.path.lexists(args.confPath):
        print("Invalid path:", args.confPath)
        return

    confLines = []
    with open(args.confPath, "r") as confFile:
        confLines = confFile.readlines()

    attIndex = 0
    with open(args.confPath, "r") as confFile:
        for index, line in enumerate(confFile):
            if args.attribute in line:
                attIndex = index
                break
            
    confLines[attIndex] = args.attribute + "=" + args.value + "\n"

    with open(args.confPath, "w") as confFile:
        confFile.writelines(confLines)

    return

if __name__ == "__main__":
    main()
