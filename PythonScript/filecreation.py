import json
import os


def filecheck(path):
    if os.path.isfile(path):
        print("file present")
    else:
        print("File does not exist ,creating file")
        filecreate(path)

def filecreate(path):
    with open(path, 'w'):
        pass


if __name__ == '__main__':
    filecheck("C:/Users/Deshraj/testing/test.json")



