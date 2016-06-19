#!/bin/bash

APP_PATH=/opt/usr/apps/nx-sftp-mod
EXT_APP_PATH=$APP_PATH/externals
JAIL_PATH=$APP_PATH/jailed_root

MOD_GUI=$EXT_APP_PATH/mod_gui
POPUP_ENTRY=$EXT_APP_PATH/popup_entry
POPUP_TIMEOUT=$EXT_APP_PATH/popup_timeout
POPUP_OK=$EXT_APP_PATH/popup_ok

kill_msg() {
    killall popup_timeout
}

show_msg() {
    kill_msg
    $POPUP_TIMEOUT "$@" 100 &
}

show_msg_timeout() {
    timeout=$1
    shift
    $POPUP_TIMEOUT "$@" $timeout
}

return_menu() {
    $MOD_GUI $APP_PATH/main
    exit 0;
}

run_jail() {
    chroot $JAIL_PATH "$@"
}

popup_back_or_close() {
    $POPUP_OK "$@" "BACK" "CLOSE" && return_menu
}
get_msg() {
    IFS=$'\n'
    for line in $1; do
        echo $line'<br>'
    done
    IFS=
}
