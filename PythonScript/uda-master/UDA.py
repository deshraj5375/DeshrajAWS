#!usr/bin/env/python3

# importing the modules
import os.path
import os
import sys
import time
import subprocess
from subprocess import call
from subprocess import check_output
import Constants
import shutil

""" Check if already the current file was downloaded"""


def uda_check():
    with open('filename.txt', 'r') as f:
        previous_fn = f.read()
    if previous_fn == Constants.FILENAME:
        print("the file was downloaded before")
        sys.exit(1)
    else:
        print("Moving to download new file")


""" UDA installation """


# def uda_install():
#    disc_agent_check = os.system("sudo ps -ef | grep -i discagnt | wc -l")
#    if disc_agent_check != 1:
#        call("sudo bash UDAinstall", shell=True)
#    else:
#        print("agent Already installed Exiting!!")
#        sys.exit(1)


def uda_install():
    disc_agent_check = os.popen("sudo ps -ef | grep -i discagnt |grep -v grep |wc -l").read()
    print("The lenght of process running are " + disc_agent_check[0])
    if int(disc_agent_check[0]) != 2:
        call("sudo bash UDAinstall", shell=True)
    else:
        print(
            "agent Already installed and shutdown existing one Process, Uninstall exiting one, and Install update one")
        disc_agent_pid = os.popen("sudo ps -ef | grep discagnt | grep -v grep| awk '{print $2}'").read().strip()
        disc_agent_pid = disc_agent_pid.split('\n')

        for pid in disc_agent_pid:
            cmd = "sudo kill -9 {}".format(pid)
            os.system(cmd)
            time.sleep(2)
            print("{} is killed".format(pid))
        uda_uninstall()
        call("sudo bash UDAinstall", shell=True)


def uda_uninstall():
    package = os.popen("sudo rpm -qa | grep ud-agent").read().strip()
    cmd = "sudo rpm -ev {}".format(package)
    os.system(cmd)
    print("pakceg is removed {}".format(package))


""" Adding firewall rules """


def firewall_rule_adding():
    fw_rule = os.system("sudo iptables -A INPUT -p tcp -s " + Constants.PROBE_IP_ADDRESS + " --dport 2738 -j ACCEPT")
    os.system("sudo firewall-cmd --permanent --add-port=2738/tcp")
    print("port is added in firwall")
    os.system("sudo firewall-cmd --reload")


""" Downloading the files"""


def downloading():
    download_file = os.system("wget " + Constants.BASE_URL + Constants.EXTENSION + Constants.FILENAME)
    if download_file == 0:
        print(Constants.FILENAME + " file downloaded")
        with open('filename.txt', 'w') as f:
            f.write(Constants.FILENAME)


""" Unzipping the downloaded package"""


def unzipping():
    unzip_file = os.system("gunzip -c " + Constants.FILENAME + " | tar xvf -" + " >> /dev/null 2>&1")
    if unzip_file == 0:
        print("uncompressed")


""" Heath check function"""


def health_check():
    healthcheck = os.popen("sudo ps -ef | grep -i discagnt | wc -l").read()
    if int(healthcheck[0]) <= 2:
        print ("The Disc agent deamon is not running. Please check")
        sys.exit(1)


""" Port Status Check"""


def port_check():
    netstatout = check_output("sudo netstat -nlp | grep 2738 | wc -l", shell=True)
    if netstatout == "0":
        print ("The port is not running please validate")
        sys.exit(1)
    else:
        print ("Port 2738 is listening. Installation Completed")


""" Main function """
##def main():
if __name__ == "__main__":
    # ip address for port mapping
    # IP_ADDRESS = sys.argv[1]

    # check if the file was previous downloaded
    uda_check()

    # executing the download function
    downloading()

    # executing the unzipping function
    unzipping()

    # storing the current working directory
    cwd = os.getcwd()
    print (cwd)

    # changing to current working directory and run installer
    os.chdir("UDA")
    uda_install()

    # changing to the root directory and running heathcheck
    health_check()
    print ("Health check for discagnt is running")

    # port status check
    port_check()

    # Removing the installers
    os.chdir(cwd)
    shutil.rmtree('UDA')
    os.remove(cwd + "/" + Constants.FILENAME)
    print ("Removed the Installer")

    # executing firewall rules addition
    firewall_rule_adding()
