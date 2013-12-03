#!/bin/bash

#---------
# Define:
#---------

name='CentOS_6-x86_64-updates'
arch='x86_64'
mirror='http://mirror.ovh.net/ftp.centos.org/6/updates/x86_64/'

#---------
# Create:
#---------

cobbler repo add --name ${name} --arch ${arch} --mirror ${mirror}
