#!/bin/bash

source /opt/usr/apps/nx-sftp-mod/common.sh

msg=$(run_jail /etc/init.d/S50sshd stop 2>&1)
popup_back_or_close "$(get_msg "$msg")"
