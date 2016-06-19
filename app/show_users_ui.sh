#!/bin/bash

source /opt/usr/apps/nx-sftp-mod/common.sh

users=$(run_jail /listusers.sh)
if [ "$users" == "" ]; then
    $POPUP_OK "Error: No registered user found." "BACK" "CLOSE" && return_menu
else
    $POPUP_OK "$(echo $users | sed 's/ /, /g')" "BACK" "CLOSE" && return_menu
fi
