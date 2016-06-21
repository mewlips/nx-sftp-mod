#!/bin/bash

source /opt/usr/apps/nx-sftp-mod/common.sh

ps ax | grep -v grep | grep /usr/sbin/sshd
sshd_started=$?

ip=$(cat /var/run/memory/dnet/ip | cut -c 2-)

if [ "$sshd_started" == 0 ]; then
    status="SFTP server is running.<br>"
else
    status="SFTP server is not started.<br>"
fi

if [ "$ip" == "" ]; then
    status="${status}Camera is not connected to network."
else
    status="${status}Camera IP Address: $ip"
fi

if [ "$sshd_started" != 0 ] || [ "$ip" == "" ]; then
    popup_back_or_close "$status"
    exit
fi

sdcard="sftp://root@$ip/sdcard"
sdcard2="root@$ip:/sdcard"
opt_usr="sftp://root@$ip/opt/usr"
opt_usr2="root@$ip:/opt/usr"

use="Use scp/sftp/sshfs clients to transfer files."

popup_back_or_close "[ SFTP Server is running. ]<br$sdcard<br>$sdcard2<br>$opt_usr<br>$opt_usr2<br>$use"
