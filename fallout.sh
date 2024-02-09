#!/usr/bin/env bash

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