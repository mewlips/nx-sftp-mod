#!/bin/bash

source /opt/usr/apps/nx-sftp-mod/common.sh

if $POPUP_OK "Do you really want to uninstall?" "YES" "NO"; then
    mkdir -p /opt/storage/sdcard/nx-on-wake
    cp -f $APP_PATH/uninstall-on-wake.sh /opt/storage/sdcard/nx-on-wake/on-wake
    sync; sync; sync
    $POPUP_TIMEOUT "Uninstall will continue after the reboot..." 4
    reboot
else
    return_menu
fi
