import boto3
import os

print(os.getcwd())
aws_iam_con=boto3.client(service_name="iam",region_name="ap-south-1")
aws_ec2_con=boto3.client(service_name="ec2",region_name="ap-south-1")
aws_s3_con=boto3.client(service_name="s3",region_name="ap-south-1")
#list iam users
response = aws_iam_con.list_users()
for item in response['Users']:
    print(item['UserName'])

#list all ec2
response=aws_ec2_con.describe_instances()
print(response)
for item in response['Reservations']:
    for subitem in item['Instances']:
        print(subitem['InstanceId'])

response=aws_s3_con.list_buckets()
for item in response['Buckets']:
    print(item['Name'])
