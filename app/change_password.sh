#!/bin/bash

source /opt/usr/apps/nx-sftp-mod/common.sh

get_password() {
    local password=$($POPUP_ENTRY "password:" "OK" "CANCEL" "nxuser")
    if [ "$password" == "" ]; then
        if $POPUP_OK "Invalid password." "RETRY" "CANCEL"; then
            get_password
            return
        else
            return_menu
        fi
    fi
    echo "$password"
}

password=$(get_password)
echo ,$password,
msg=$( (echo $password; echo $password) | run_jail passwd)
if [ $? == 0 ]; then
    popup_back_or_close "Password changed successfully."
else
    popup_back_or_close "Error: $(get_msg "$msg")"
fi
