#!/bin/bash
#----------------------------------------------------------
# test bash if

echo This tool is DESTRUCTIVE. Ensure that you are using this on the correct account! Press enter to continue

read x

sudo wget https://github.com/gruntwork-io/cloud-nuke/releases/download/v0.1.24/cloud-nuke_linux_amd64
sudo mv cloud-nuke_linux_amd64 /usr/local/bin/cloud-nuke
cd /usr/local/bin
sudo chmod u+x cloud-nuke
sudo cloud-nuke aws