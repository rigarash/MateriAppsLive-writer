#!/bin/sh

IMAGE="$1"

DEVS=$(ls /dev/sd[a-z])
for d in $DEVS; do
  sudo sh /home/pi/write_usb.sh $IMAGE $d dd &
done
wait

