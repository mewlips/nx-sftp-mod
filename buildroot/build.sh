#!/bin/sh

TARBALL=buildroot-2016.05.tar.bz2
DEFCONFIG=nx_sftp_mod_defconfig
BUILDROOT_DIR=buildroot-2016.05

wget -c https://buildroot.org/downloads/$TARBALL

if [ -f $TARBALL ] && [ ! -d $BUILDROOT_DIR ]; then
    tar -xjf $TARBALL
fi

cp -fv nx_sftp_mod_defconfig $BUILDROOT_DIR/configs
cd $BUILDROOT_DIR
make nx_sftp_mod_defconfig && make && \
    cp -fv output/images/rootfs.tar ../../app
