#!/bin/sh

# This utility is based on Mathlibre mkusbmath tool
# https://github.com/knxm/mathlibre/blob/master/config/includes.chroot/usr/sbin/mkusbmath

DIR="$1"
DEV="$2"
if [ -z "$DEV" ]; then
  echo "Usage: $0 directory device"
  exit 127
fi
if [ -d "$DIR" ]; then :; else
  echo "Error: directory not found ($DIR)"
  exit 127
fi

echo "Info: source directory = $DIR"
echo "Info: target device = $DEV"

NUM="1 2 3 4 5 6 7 8"
for n in $NUM; do
  r=`(df | grep $DEV$n > /dev/null 2>&1); echo $?`
  if [ $r = "0" ]; then
    echo "Info: umounting $DEV$n"
    umount $DEV$n
  fi
done

echo "Info: format $DEV"
mkfs.vfat -v -n MATERIAPPS -F 32 ${DEV}1

echo "Info: start writing MateriApps LIVE! files"
mkdir -p /mnt/tmp$DEV
mount -t vfat ${DEV}1 /mnt/tmp$DEV
cp $DIR/* /mnt/tmp$DEV
cd /mnt/tmp$DEV
md5sum --check ${HOME}/${DIR}.md5
cd
umount /mnt/tmp$DEV
rmdir /mnt/tmp$DEV

echo "Info: done"
