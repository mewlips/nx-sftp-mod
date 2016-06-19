#!/bin/bash

source /opt/usr/apps/nx-sftp-mod/common.sh

add_ssh_key() {
    local ssh_key_path=$($POPUP_ENTRY "SSH Key:" "OK" "CANCEL" "/sdcard/id_rsa.pub")
    if [ -f "$ssh_key_path" ]; then
        mkdir -p $JAIL_PATH/root/.ssh/
        cat "$ssh_key_path" >> $JAIL_PATH/root/.ssh/authorized_keys
        rm "$ssh_key_path"
        popup_back_or_close "Your SSH key added."
    else
        if $POPUP_OK "file not found" "RETRY" "CANCEL"; then
            add_ssh_key
            return
        else
            return_menu
        fi
    fi
}

add_ssh_key
