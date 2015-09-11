#!/bin/sh

mkdir -p /mnt/ma
mkdir -p /mnt/maroot

DEVS=$(ls /dev/sd[a-z]1)
for d in $DEVS; do
  sudo mount $d /mnt/ma > /dev/null 2>&1
  if test -f /mnt/ma/live/filesystem.squashfs; then
    sudo mount /mnt/ma/live/filesystem.squashfs /mnt/maroot
    if test -f /mnt/maroot/etc/materiapps_version; then
      VER=$(cat /mnt/maroot/etc/materiapps_version)
    fi
    sudo umount /mnt/maroot
  elif test -f /mnt/ma/README.html; then
    VER="VFAT"
  fi
  sudo umount /mnt/ma
  echo $d $VER
  DEV=${d%%[1]}
  if [ -n "$1" ]; then
    parted $DEV print
  fi
done
