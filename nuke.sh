#!/bin/bash
#----------------------------------------------------------
# test bash if

sudo wget https://github.com/gruntwork-io/cloud-nuke/releases/download/v0.1.24/cloud-nuke_linux_amd64
sudo mv cloud-nuke_linux_amd64 /usr/local/bin/cloud-nuke
cd /usr/local/bin
sudo chmod u+x cloud-nuke
sudo cloud-nuke aws