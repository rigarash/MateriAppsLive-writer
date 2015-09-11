#!/bin/sh

echo "d
1

d
1

d
1

d
1

n
p
1


a
1
c

t
c
w
"|fdisk $@
echo "p
q
"|fdisk $@
