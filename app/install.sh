#!/bin/bash

ON_WAKE=/opt/storage/sdcard/nx-on-wake/on-wake
INSTALL_PATH=/opt/storage/sdcard/app
APP_PATH=/opt/usr/apps/nx-sftp-mod
JAIL_PATH=$APP_PATH/jailed_root
EXT_APP_PATH=/tmp/externals
NX_MODEL=$EXT_APP_PATH/nx-model
POPUP_TIMEOUT=$EXT_APP_PATH/popup_timeout
POPUP_OK=$EXT_APP_PATH/popup_ok

mkdir -p $EXT_APP_PATH
cp -av $INSTALL_PATH/externals/{nx-model,popup_ok,popup_timeout} $EXT_APP_PATH

# ========= force LCD on (crash on EVF) =========
st app disp lcd
sleep 1

# ========= only run on suitable firmware =========
if [ "$($NX_MODEL)" != nx500 ] && [ "$($NX_MODEL)" != nx1 ]; then
    $POPUP_OK "Camera or firmware not supported.\n\nPress OK to exit"
    exit
fi

# ========= some useful functions =========
show_msg() {
    killall popup_timeout
    $POPUP_TIMEOUT "$1" 100 &
}

show_msg " [ nx-sftp-mod v0.9 ] "
sleep 2

# ========= clean-up existing mod ========
# check mounted state
if mount 2>&1 | grep $JAIL_PATH; then
    $POPUP_TIMEOUT " [ Cold reboot required. Now rebooting... ]" 2
    reboot
fi

show_msg " [ Removing old version... ] "
if [ -d $APP_PATH ]; then
    sleep 2
    rm -rfv $APP_PATH
fi

# ========= copy stuff ========
show_msg " [ Installing files ... ] "

# set up jailed root environment
mkdir -pv $JAIL_PATH
tar -C $JAIL_PATH -xf $INSTALL_PATH/rootfs.tar
rm -fv $INSTALL_PATH/rootfs.tar

# enable root login
sed 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' $JAIL_PATH/etc/ssh/sshd_config > /tmp/sshd_config
mv -fv /tmp/sshd_config $JAIL_PATH/etc/ssh/sshd_config

# create device files for ssh
mknod $JAIL_PATH/dev/fuse c 10 229
mknod $JAIL_PATH/dev/null c 1 3
chmod 666 $JAIL_PATH/dev/null
mknod $JAIL_PATH/dev/random c 1 8
mknod $JAIL_PATH/dev/urandom c 1 9

# create some directories
mkdir -p $JAIL_PATH/home
mkdir -p $JAIL_PATH/root/.ssh
if [ -f $INSTALL_PATH/id_rsa.pub ]; then
    mv $INSTALL_PATH/id_rsa.pub $JAIL_PATH/root/.ssh/authorized_keys
fi
mkdir -p $JAIL_PATH/opt/usr
mkdir -p $JAIL_PATH/sdcard

# copy files
cp -rv $INSTALL_PATH/* $APP_PATH
mv $APP_PATH/AEL_AEL.sh /opt/usr/nx-on-wake/

# ========= clean up ========
rm -rfv $INSTALL_PATH
rm -fv $APP_PATH/install.sh
rm -fv $ON_WAKE
rm -rfv $EXT_APP_PATH

sync; sync; sync;
killall popup_timeout
$APP_PATH/externals/popup_ok "Installation completed!<br><br>When you dobule-clicking the [AEL] button will bring up nx-sftp-mod menu.<br>To change the password,<br>select 'Change password' from the menu.<br>" "YES" "OK"
