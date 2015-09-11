#!/bin/sh

DEVS=$(ls /dev/sd[a-z])

while true
do
  for d in $DEVS; do
    dd if=$d of=/dev/null count=100 > /dev/null 2>&1
  done
done
