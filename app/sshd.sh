#!/bin/bash

source /opt/usr/apps/nx-sftp-mod/common.sh

check_mount() {
    if [ -f /opt/storage/sdcard/nx-on-wake/on-wake ]; then
        if $POPUP_OK "'nx-on-wake/on-wake' is exist on the sdcard.<br>It will conflict with this mod.<br>Would you delete the 'nx-on-wake/on-wake' file?" "Yes, delete it." "No."; then
            rm -f /opt/storage/sdcard/nx-on-wake/on-wake
        else
            show_msg_timeout 4 "Starting SFTP server is canceled."
            exit 0
        fi
    fi
    src=$1
    dest=$2
    mount 2>&1 | grep $dest || mount -o bind $src $dest
}

check_mount /opt/storage/sdcard $JAIL_PATH/sdcard
check_mount /proc $JAIL_PATH/proc
check_mount /sys $JAIL_PATH/sys
check_mount /opt/usr $JAIL_PATH/opt/usr

show_msg "Please wait..."
msg=$(run_jail /etc/init.d/S50sshd start 2>&1)
kill_msg
popup_back_or_close "$(get_msg "$msg")"
