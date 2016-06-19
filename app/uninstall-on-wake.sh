#!/bin/bash

APP_PATH=/opt/usr/apps/nx-sftp-mod

$APP_PATH/externals/popup_timeout " [ Uninstalling nx-sftp-mod ... ] " 10

if [ -d $APP_PATH ]; then
    rm -rf $APP_PATH
fi

rm -f /opt/storage/sdcard/nx-on-wake/on-wake

sync; sync; sync
sleep 2
reboot
