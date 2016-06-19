#!/bin/bash

source /opt/usr/apps/nx-sftp-mod/common.sh

username=$($POPUP_ENTRY "username:" "OK" "CANCEL" "nxuser")
if [ $username == "" ]; then
    show_msg_timeout 2 "Invalid username."
    return_menu
fi

msg=$(run_jail /deluser.sh $username)
if [ $? == 0 ]; then
    popup_back_or_close "User deleted successfully. ($username)"
else 
    popup_back_or_close "Error: $(get_msg "$msg")"
fi
