#!/bin/bash
sudo su - root
yum install httpd -y
echo "This is created from Terraform" > /var/www/html/index.html                
service httpd start
yum update -y
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
service sshd restart 
yum install -y amazon-efs-utils
mkdir efs
efs_id="${efs_id}"
mount -t efs $efs_id:/ /efs
echo $efs_id:/ /efs efs defaults,_netdev 0 0 >> /etc/fstab