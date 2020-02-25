import os


def fun_createFolder():
    dirPrefix='f0'
    for i in range(100,151):
        dirname=dirPrefix+str(i)
        pathtoadd="C:/Users/deshraj/testing/"+dirname
        os.mkdir(pathtoadd)
        print(pathtoadd)


if __name__ == '__main__':
    fun_createFolder()


