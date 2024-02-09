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

echo Nuke completed. Removing all IAM users.


_process_user() {
    _detach_policies $1 &
    _delete_access_keys $1 &
    wait
    _delete_user $1 &
}

_detach_policies() {
    policies=$(aws iam list-attached-user-policies --user-name $1 | jq -r '.AttachedPolicies[] .PolicyArn')

    for policy in $policies; do
        echo Policy detach: $1 - $policy
        aws iam detach-user-policy --user-name $1 --policy-arn $policy &
    done
    wait
}

_delete_access_keys() {
    items=$(aws iam list-access-keys --user-name $1 | jq -r '.AccessKeyMetadata[] .AccessKeyId')

    for item in $items; do
        echo Access Key remove: $1 - $item
        aws iam delete-access-key --user-name $1 --access-key-id $item &
    done
    wait
}

_delete_user() {
    echo User delete: $1
    aws iam delete-user --user-name $1
}

main() {
    users=$(aws iam list-users | jq -r '.Users[] .UserName' | grep 'hip-new-branches-')

    for user in $users; do
        _process_user "$user"
    done
}

main