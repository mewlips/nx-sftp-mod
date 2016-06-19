#!/bin/bash

source /opt/usr/apps/nx-sftp-mod/common.sh

get_username() {
    local username=$($POPUP_ENTRY "username:" "OK" "CANCEL" "nxuser")
    if [ "$username" == "" ]; then
        if $POPUP_OK "Invalid username." "RETRY" "CANCEL"; then
            get_username
            return
        else
            return_menu
        fi
    fi
    echo "$username"
}

get_password() {
    local password=$($POPUP_ENTRY "password:" "OK" "CANCEL" "nxuser")
    if [ "$password" == "" ]; then
        if $POPUP_OK "Invalid password." "RETRY" "CANCEL"; then
            get_username
            return
        else
            return_menu
        fi
    fi
    echo "$password"
}

username=$(get_username)
password=$(get_password)

show_msg "Please wait..."
msg=$(run_jail /adduser.sh $username $password)
if [ $? == 0 ]; then
    kill_msg
    popup_back_or_close "New user added successfully. ($username)"
else 
    kill_msg
    popup_back_or_close "Error: $(get_msg "$msg")"
fi
