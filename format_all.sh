#!/bin/sh

DEVS=$(ls /dev/sd[a-z])
for d in $DEVS; do
  sudo sh /home/pi/format_usb.sh $d
done
wait

