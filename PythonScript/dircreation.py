import os
import sys

"""
This is to create and remove folder from f0100 to f0150.
Program will accept input 1 for creating folder from command line. 2 for removing. 

"""


def fun_createFolder(pathtoadd):
    try:
        os.mkdir(pathtoadd)
    except:
        print("Unable to create dir")


def fun_removeFolder(pathtoadd):
    try:
        os.rmdir(pathtoadd)
    except:
        print("Unable to delete dir")


if __name__ == '__main__':

    argumentList=sys.argv
    print(argumentList[1])
    dirPrefix = 'f0'
    for i in range(100,151):
        dirname=dirPrefix+str(i)
        pathtoadd="C:/Users/Deshraj/testing/"+dirname
        if int(argumentList[1]) == 1:
            fun_createFolder(pathtoadd)
        elif int(argumentList[1]) == 2:
            fun_removeFolder(pathtoadd)
        else:
            print("Wrong choice")









