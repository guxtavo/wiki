#!/bin/bash

# Warning! Use at your own risk -> it might damage your initrd
# This program is not fully tested and contain bugs

# Input: initrd file, file to be edited inside initrd
# Output: temp directory with extracted initrd, call to edit the file, and
#         packing

if  [ $# -ne 2 ] ;  then
    echo "Missing Argument(s) - USAGE:"
    echo "      \$PATH/"$(basename $0)" <initrd> <file to edit>>"
    echo ""
    echo "initrd-4.4.178-94.91-default-kdump etc/cmdline.d/99kdump-net.conf"
    exit 1
fi

TEMP_DIR=$(mktemp -d /dev/shm/initrd.XXXXXXXX) || { echo "Failed!"; exit 1; }
echo ${TEMP_DIR}
cd /boot
cp $1 $TEMP_DIR/$1.orig
cd $TEMP_DIR
unxz -dc $1.orig > $1.img
mkdir initrd-work
cd initrd-work
cpio -i < $TEMP_DIR/$1.img
vi $2
find . | cpio -H newc -o > $TEMP_DIR/newinitrd.img
cd $TEMP_DIR
#  Initramfs unpacking failed: Input was encoded with settings that are not
#  supported by this XZ decoder - using gzip until I find a workaround
gzip -c newinitrd.img > /boot/$1
echo "Almost done"
systemctl restart kdump
rm -rf $TEMP_DIR
