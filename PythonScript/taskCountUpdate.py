import json
import sys

replaceValue=sys.argv[1]
f=open("test.json",'r')
fileData=json.load(f)
for i in fileData:
  if i['ParameterKey'] == 'DesiredCount':
    i['ParameterValue']=replaceValue 
    break  
f.close() 
with open('test.json', 'w') as f:
        json.dump(fileData, f)