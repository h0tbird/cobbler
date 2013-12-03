#!/bin/bash

#---------
# Define:
#---------

h='router01.demo.lan'
profile='Virtual'
hdpath="/dev/vg0/${h}"
ram='1024'
cpu='2'
m0=`echo $h | md5sum | sed "s/\([0-9a-z]\{2\}\)\([0-9a-z]\{2\}\)\([0-9a-z]\{2\}\).*/00:16:3e:\1:\2:\3/g"`
m1=`printf %.6X $(( 0x\`echo $h | md5sum | cut -c-6\` + 1 )) | \
tr [A-Z] [a-z] | sed "s/\([0-9a-z]\{2\}\)\([0-9a-z]\{2\}\)\([0-9a-z]\{2\}\).*/00:16:3e:\1:\2:\3/g"`
m2=`printf %.6X $(( 0x\`echo $h | md5sum | cut -c-6\` + 2 )) | \
tr [A-Z] [a-z] | sed "s/\([0-9a-z]\{2\}\)\([0-9a-z]\{2\}\)\([0-9a-z]\{2\}\).*/00:16:3e:\1:\2:\3/g"`
i0='192.168.1.1'
gw='192.168.1.1'
dns='8.8.8.8'

#---------
# Create:
#---------

cobbler system remove --name=$h
cobbler system add  --name=$h --profile=$profile --hostname=$h --name-servers=$dns --gateway=$gw
cobbler system edit --name=$h --virt-ram=$ram --virt-auto-boot=1 --virt-type=kvm --virt-cpus=$cpu --virt-path=$hdpath
cobbler system edit --name=$h --interface=eth0 --mac=$m0 --ip-address=$i0 --subnet=255.255.255.0 --static=1 --virt-bridge=br0
cobbler system edit --name=$h --interface=eth1 --mac=$m1 --static=0 --virt-bridge=br1_3
cobbler system edit --name=$h --interface=eth2 --mac=$m2 --static=1 --virt-bridge=br1_6
cobbler system edit --name=$h --kopts="serial console=ttyS0,115200 ksdevice=eth0"
cobbler system edit --name=$h --kopts-post="serial console=ttyS0,115200 ksdevice=eth0"
