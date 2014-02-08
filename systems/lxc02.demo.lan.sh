#!/bin/bash

#---------
# Define:
#---------

h='lxc02.demo.lan'
profile='CentOS_Virtual'
hdpath="/dev/vg0/${h}"
ram='4096'
cpu='2'
m0=`echo $h | md5sum | sed "s/\([0-9a-z]\{2\}\)\([0-9a-z]\{2\}\)\([0-9a-z]\{2\}\).*/00:16:3e:\1:\2:\3/g"`
m1=`printf %.6X $(( 0x\`echo $h | md5sum | cut -c-6\` + 1 )) | \
tr [A-Z] [a-z] | sed "s/\([0-9a-z]\{2\}\)\([0-9a-z]\{2\}\)\([0-9a-z]\{2\}\).*/00:16:3e:\1:\2:\3/g"`
m2=`printf %.6X $(( 0x\`echo $h | md5sum | cut -c-6\` + 2 )) | \
tr [A-Z] [a-z] | sed "s/\([0-9a-z]\{2\}\)\([0-9a-z]\{2\}\)\([0-9a-z]\{2\}\).*/00:16:3e:\1:\2:\3/g"`
i0='192.168.1.6'
n0='255.255.255.0'
gw='192.168.1.1'
dns='8.8.8.8'

#---------
# Create:
#---------

cobbler system remove --name=$h
cobbler system add  --name=$h --profile=$profile --hostname=$h --name-servers=$dns --gateway=$gw
cobbler system edit --name=$h --virt-ram=$ram --virt-auto-boot=1 --virt-type=kvm --virt-cpus=$cpu --virt-path=$hdpath
cobbler system edit --name=$h --interface=br0 --interface-type=bridge --bridge-opts="stp=no" --ip-address=$i0 --netmask=$n0 --static=1
cobbler system edit --name=$h --interface=br1 --interface-type=bridge --bridge-opts="stp=no" --static=1
cobbler system edit --name=$h --interface=br2 --interface-type=bridge --bridge-opts="stp=no" --static=1
cobbler system edit --name=$h --interface=eth0 --mac=$m0 --interface-type=bridge_slave --interface-master=br0 --static=1 --virt-bridge=br0
cobbler system edit --name=$h --interface=eth1 --mac=$m1 --interface-type=bridge_slave --interface-master=br1 --static=1 --virt-bridge=br1_3
cobbler system edit --name=$h --interface=eth2 --mac=$m2 --interface-type=bridge_slave --interface-master=br2 --static=1 --virt-bridge=br1_6
cobbler system edit --name=$h --kopts="serial console=ttyS0,115200 ksdevice=eth0"
cobbler system edit --name=$h --kopts-post="serial console=ttyS0,115200 ksdevice=eth0"
