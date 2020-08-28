#!/usr/bin/env python

###########################################################################
# This script will install the UDA and check the status 
#
#
# Created      :26/08/2020
#
# Version 0.1- Desh
############################################################################
import os.path
import os
import socket
import syslog
import sys
import urllib
import tarfile
import subprocess
from subprocess import call
from subprocess import check_output

def udaInstall():
    returnResult=os.system("ps -ef|grep -i discagnt >> /dev/null 2>&1")    
    if not returnResult == 0:        
        call("sudo bash UDAinstall", shell=True)
    else:
        print("agent Already installed") 
        sys.exit(1) 

def firewallRuleadding():
    returnResult=os.system("sudo iptables -A INPUT -s 192.168.132.0/17 -j ACCEPT")
    if not returnResult == 0:
        print("Issue setting up port in firewall")
    else:
        print("port is added in firwall")

returnResult=os.system("curl -k --user username:password https://URL --output UDAinstall_11.50b.tar.gz >> /dev/null 2>&1")    
if returnResult == 0:        
    print("UDA tar.gz file downloaded")   
returnResult=os.system("tar -xvf UDAinstall_11.50b.tar.gz >> /dev/null 2>&1")    
if returnResult == 0:        
    print("uncompressed")         

os.chdir("UDA")
udaInstall()
os.chdir("/root")
healthCheck=os.system("systemctl status discagnt")
if not healthCheck == "0":
  print "The Disagnt deamon is not running. Please check"
  sys.exit(1)

print "Health check for discagnt is running"
NetStatOut=check_output("netstat -nlp | grep 2738 | wc -l", shell=True)
if NetStatOut == "0":
  print "The port is not running please validate"
  sys.exit(1)
print "Port 2738 is listening. Installation Completed"

#Removing the installers
os.rmdir("/root/UDA")
os.remove("UDAinstall_11.50b.tar.gz")
print "Removed the Installer"
firewallRuleadding()
