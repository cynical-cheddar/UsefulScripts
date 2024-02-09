#!/bin/bash
#----------------------------------------------------------
# test bash if

echo This tool is DESTRUCTIVE. Ensure that you are using this on the correct account! 
echo Cross-reference the account-name located in the top-right with the account-name in the central spreadsheet.
echo This should ONLY be used on student accounts due for suspension and deletion - NEVER on the management account.
echo Press enter to continue or exit with ctrl + c.

read x

sudo wget https://github.com/gruntwork-io/cloud-nuke/releases/download/v0.1.24/cloud-nuke_linux_amd64
sudo mv cloud-nuke_linux_amd64 /usr/local/bin/cloud-nuke
cd /usr/local/bin
sudo chmod u+x cloud-nuke
sudo cloud-nuke aws