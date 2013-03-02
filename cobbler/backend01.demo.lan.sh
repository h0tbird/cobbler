#!/bin/bash

#---------
# Define:
#---------

h=backend01.demo.lan
profile=Virtual
hdpath=/mnt/data/$h.img
ram=768
cpu=1
m0=`echo $h | md5sum | sed "s/\([0-9a-z]\{2\}\)\([0-9a-z]\{2\}\)\([0-9a-z]\{2\}\).*/00:16:3e:\1:\2:\3/g"`
i0=192.168.2.5
gw=192.168.2.1
dns=8.8.8.8

#---------
# Create:
#---------

cobbler system remove --name=$h
cobbler system add  --name=$h --profile=$profile --hostname=$h --name-servers=$dns --gateway=$gw
cobbler system edit --name=$h --virt-ram=$ram --virt-auto-boot=1 --virt-type=kvm --virt-cpus=$cpu --virt-path=$hdpath
cobbler system edit --name=$h --interface=eth0 --mac=$m0 --ip-address=$i0 --subnet=255.255.255.0 --static=1 --virt-bridge=br0
cobbler system edit --name=$h --kopts="ksdevice=eth0"
