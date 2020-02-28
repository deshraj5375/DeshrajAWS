
def networkFetch():
    filePointer=open("buFile.txt",'r')
    filePointerWrite=open("network.txt",'w')
    for i in filePointer:
        tempString=str(i).split(' ')[0]
        if tempString[0]!= '#':
            tempString=tempString+"\n"
            filePointerWrite.write(tempString)
    filePointer.close()
    filePointerWrite.close()

if __name__ == '__main__':
    networkFetch()




