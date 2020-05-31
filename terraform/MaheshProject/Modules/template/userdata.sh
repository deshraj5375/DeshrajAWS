#!/bin/bash
yum update -y
useradd tibcouser -u 32978 -m -s /bin/bash -c "tibco local user"
echo "tibcouser:tibcouser" |chpasswd
echo "root:password"|chpasswd
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
service sshd restart                
yum install httpd -y
echo "This is created from Terraform" > /var/www/html/index.html                
service httpd start