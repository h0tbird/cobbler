#!/bin/bash

#---------
# Define:
#---------

h=kvm01.demo.lan
profile=Hardware
m0=4c:72:b9:26:25:97
m1=4c:72:b9:26:25:98
i0=192.168.2.10
n0=255.255.255.0
gw=192.168.2.1
dns=8.8.8.8

#---------
# Create:
#---------

cobbler system remove --name=$h
cobbler system add  --name=$h --profile=$profile --hostname=$h --name-servers=$dns --gateway=$gw
cobbler system edit --name=$h --interface=eth0 --mac=$m0 --interface-type=bridge_slave --interface-master=br0
cobbler system edit --name=$h --interface=eth1 --mac=$m1 --interface-type=bridge_slave --interface-master=br1
cobbler system edit --name=$h --interface=br0 --interface-type=bridge --bridge-opts="stp=no" --ip-address=$i0 --netmask=$n0 --static=1
cobbler system edit --name=$h --interface=br1 --interface-type=bridge --bridge-opts="stp=no" --static=1
cobbler system edit --name=$h --kopts="ksdevice=eth0"
