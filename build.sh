#!/bin/sh

ZIP_FILE=nx-sftp-mod.zip

rm -f $ZIP_FILE
zip -r $ZIP_FILE app/ nx-on-wake/
