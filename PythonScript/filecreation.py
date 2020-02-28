import json
import os
import sys


def filecheck(path):
    if os.path.isfile(path):
        print("file present")
    else:
        print("File does not exist ,creating file")
        filecreate(path)

def filecreate(path):
    with open(path, 'w'):
        pass
    print(" {} is created".format(path))

def fileDelete(path):
    if os.path.isfile(path):
        print("File present, Deleting")
        os.remove(path)

    else:
        print("File does not exist , Not deleting file")



if __name__ == '__main__':
    #fileDelete(str(sys.argv[1]))
    filecheck(str(sys.argv[1]))





