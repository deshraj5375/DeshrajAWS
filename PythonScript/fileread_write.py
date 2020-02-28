def funDif():
    cloud=[]
    onprem=[]

    onpremdata=open("first.txt", 'r')
    for i in onpremdata:
        onprem.append(i)
    onpremdata.close()

    clouddata=open("first1.txt", 'r')
    for i in clouddata:
        cloud.append(i)
    clouddata.close()

    filecheck(onprem,cloud)

def filecheck(onprem,cloud):
    tableNotPresentOnCloud=[]
    for i in onprem:
        if i not in cloud:
            #print("{} is not preset in cloud".format(i))
            tableNotPresentOnCloud.append(i)
    diffdata=open("first2.txt", 'w')
    diffdata.writelines(tableNotPresentOnCloud)
    diffdata.close()
    print(len(tableNotPresentOnCloud))
    print(tableNotPresentOnCloud)

if __name__ == '__main__':
    funDif()